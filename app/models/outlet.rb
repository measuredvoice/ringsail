# == Schema Information
#
# Table name: outlets
#
#  id                :integer          not null, primary key
#  service_url       :string(255)
#  organization      :string(255)
#  account           :string(255)
#  language          :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  service           :string(255)
#  status            :integer          default(0)
#  draft_id          :integer
#  short_description :text(65535)
#  long_description  :text(65535)
#
require 'elasticsearch/model'

class Outlet < ActiveRecord::Base
  #handles logging of activity
  include PublicActivity::Model
  include Notifications
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks


  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :id, type: :integer
      indexes :title, analyzer: 'english'
      indexes :agencies, analyzer: 'english'
      indexes :service, analyzer: 'english'
      indexes :contacts, analyzer: 'english'
      indexes :account_name, analyzer: 'english'
      indexes :account, type: :string
      indexes :status, analyzer: 'english'
      indexes :draft_id, type: :integer
      indexes :updated_at, type: :date
    end
  end

  def as_indexed_json(options={})
    result = {
      id: self.id,
      draft_id: self.draft_id,
      service: self.service,
      agencies: self.agencies.map(&:name).join(", "),
      contacts: self.users.map(&:email).join(", "),
      account_name: self.organization,
      account: self.account,
      status: self.status.humanize,
      updated_at: self.updated_at
    }
    if self.service == "facebook"
      result['facebook_followers'] = Random.rand(900)
      result['facebook_likes'] = Random.rand(900)
      result['facebook_posts'] = Random.rand(100)
    end
    if self.service == "twitter"
      result['twitter_followers'] = Random.rand(900)
      result['twitter_posts'] = Random.rand(100)
    end
    result
  end

  tracked owner: Proc.new{ |controller, model| controller.current_user }

  scope :by_agency, lambda {|id| joins(:agencies).where("agencies.id" => id) }
  scope :api, -> { where("draft_id IS NOT NULL") }

  enum status: { under_review: 0, published: 1, archived: 2,
    publish_requested: 3, archive_requested: 4 }
  
  # Outlets have a relationship to themselvs
  # The "published" outlet will have a draft_id pointing to its parent
  # The "draft" outlet will not have a draft_id field
  # This will allow easy querying on the public / admin portion of the application
  has_one :published, class_name: "Outlet", foreign_key: "draft_id", dependent: :destroy
  belongs_to :draft, class_name: "Outlet", foreign_key: "draft_id"

  # These are has and belongs to many relationships
  has_many :sponsorships, dependent: :destroy
  has_many :agencies, :through => :sponsorships

  has_many :outlet_users, dependent: :destroy
  has_many :users, :through => :outlet_users

  has_many :outlet_official_tags, dependent: :destroy
  has_many :official_tags, :through => :outlet_official_tags

  has_many :gallery_items, as: :item, dependent: :destroy
  has_many :galleries, through: :gallery_items, source: "Outlet"

  # acts as taggable is being kept until we do a final data migration (needed for backwards compatibility)
  acts_as_taggable

  # Published outlets should not.
  validates :service,
    :presence   => true
  validates :service_url,
    :presence   => true,
    :format     => { :with => URI::regexp(%w(http https)) }

  validates :language, :presence => true
  validates :agencies, :length => { :minimum => 1, :message => "have at least one sponsoring agency" }
  validates :users, :length => { :minimum => 1, :message => "have at least one contact" }

  paginates_per 100

  # def service_info
  #   if self.service_url && self.service
  #     if self.service_info.account
  #       self.account = self.service_info.account
  #     else
  #       self.errors.push(:service_url, "should be able to be parsed from URL, check the format you provided. If you believe this to be in error, contact an administrator")
  #     end
  #   end
  # end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << (column_names + ["agencies" ,"contacts" ,"tags"])

      self.all.includes(:agencies,:users,:official_tags).each do |outlet|
        csv << (outlet.attributes.values_at(*column_names) + [outlet.agencies.map(&:name).join("|") ,outlet.users.map(&:email).join("|"),outlet.official_tags.map(&:tag_text).join("|")])
      end
    end
  end

  def self.export_csv(options={})
    CSV.generate(options) do |csv|
      csv << ["agencies" ,"account_type","account name","account url", "tags", "updated"]

      self.all.includes(:agencies,:users,:official_tags).each do |outlet|
        csv << [outlet.agencies.map(&:name).join("|") ,outlet.service, outlet.organization, outlet.service_url, outlet.official_tags.map(&:tag_text).join("|"), outlet.updated_at]
      end
    end
  end

  def self.es_search(params, sort_column, sort_direction)
    query = {
      query: {
        bool: {
          must: [
            {
              constant_score: {
                filter: {
                  missing: {
                    field: "draft_id",
                    existence: true,
                    null_value: true
                  }
                }
              }
            }
          ],
          should: []
        }
      },
      sort: [
        { "#{sort_column}" => "#{sort_direction}"}
      ]
    }
    if !params["sSearch"].blank?
      query[:query][:bool][:must] <<  {
                                        match: { 
                                          _all: {
                                            query: "%#{params["sSearch"]}%"
                                          }
                                        }
                                      }
    end
    if !params[:service].blank?
      query[:query][:bool][:must] << {
                                        match: {
                                          "service" => params[:service]
                                        }
                                      }
    end
    if !params[:status].blank?
      query[:query][:bool][:must] << {
                                        match_phrase: {
                                          "status" => params[:status]
                                        }
                                      }
    end
    if !params[:agency].blank?
      query[:query][:bool][:must] << {
                                        match_phrase: {
                                          "agencies" => params[:agency]
                                        }
                                      }
    end
    self.search(query)
  end

  def self.to_review
    where('outlets.updated_at < ?', 6.months.ago).order('outlets.updated_at')
  end

  def self.resolve(url)
    return nil if url.nil? || url.empty?

    url = 'http://' + url unless url =~ %r{(?i)\Ahttps?://}

    s = Admin::Service.find_by_url(url)

    return nil unless s

    existing = self.find_by_account_and_service(s.account, s.shortname)
    if existing
      return existing
    else
      return nil
    end
  end

  def self.resolves(url)
    return nil if url.nil? || url.empty?

    url = 'http://' + url unless url =~ %r{(?i)\Ahttps?://}

    s = Admin::Service.find_by_url(url)

    return nil unless s

    existing = self.where(account: s.account, service: s.shortname).where("draft_id IS NOT NULL")
    if existing
      return existing
    else
      return nil
    end
  end

  def service_info
    @service_info ||= Admin::Service.find_by_url(service_url)
  end

  def agency_tokens=(ids)
    self.agency_ids = ids.split(",")
  end

  # will rely on replacing the tokens system, but CRUDing out the info for now
  def tag_tokens=(ids)
    current_ids = []
    ids.split(",").each do |id|
      current_ids << OfficialTag.find_or_create_by(tag_text: id).id
    end
    self.official_tag_ids = current_ids
  end

  def user_tokens=(ids)
    self.user_ids = ids.split(",")
  end


  def published!
    Outlet.public_activity_off
    self.status = Outlet.statuses[:published]
    self.published.destroy! if self.published
    new_outlet = Outlet.new({
      service_url: self.service_url,
      service: self.service,
      organization: self.organization,
      account: self.account,
      language: self.language,
      short_description: self.short_description,
      long_description: self.long_description,
      agency_ids: self.agency_ids || [],
      user_ids: self.user_ids || [],
      official_tag_ids: self.official_tag_ids || [],
      status: self.status,
      draft_id: self.id
    })
    new_outlet.save(validate: false)
    self.save(validate: false)
    Outlet.public_activity_on
    self.create_activity :published
  end

  def archived!
    Outlet.public_activity_off
    self.status = Outlet.statuses[:archived]
    self.published.destroy! if self.published
    self.save(validate: false)
    Outlet.public_activity_on
    self.create_activity :archived
  end

  def publish_requested!
    Outlet.public_activity_off
    self.status = Outlet.statuses[:publish_requested]
    self.save(validate: false)
    Outlet.public_activity_on
    self.create_activity :publish_requested
  end

  def archive_requested!
    Outlet.public_activity_off
    self.status = Outlet.statuses[:archive_requested]
    self.save(validate: false)
    Outlet.public_activity_on
    self.create_activity :archive_requested
  end

  private

  def set_updated_by
    current_token = AuthToken.find_valid_token(auth_token)
    if !current_token.nil?
      self.updated_by = current_token.email
    else
      self.updated_by ||= 'admin'
    end
  end
end
