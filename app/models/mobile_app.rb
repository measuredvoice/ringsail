# == Schema Information
#
# Table name: mobile_apps
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  short_description :text(65535)
#  long_description  :text(65535)
#  icon_url          :string(255)
#  language          :string(255)
#  agency_id         :integer
#  status            :integer          default("0")
#  mongo_id          :string(255)
#  draft_id          :integer
#

class MobileApp < ActiveRecord::Base
  #handles logging of activity
  include PublicActivity::Model
  include Notifications
  
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  scope :by_agency, lambda {|id| joins(:agencies).where("agencies.id" => id) }
  scope :api, -> { where("draft_id IS NOT NULL") }

  enum status: { under_review: 0, published: 1, archived: 2, 
    publish_requested: 3, archive_requested: 4 }

  # Outlets have a relationship to themselvs
  # The "published" outlet will have a draft_id pointing to its parent
  # The "draft" outlet will not have a draft_id field
  # This will allow easy querying on the public / admin portion of the application
  has_one :published, class_name: "MobileApp", foreign_key: "draft_id", dependent: :destroy
  belongs_to :draft, class_name: "MobileApp", foreign_key: "draft_id"

  #attr_accessible :name, :shortname, :info_url, :agency_contact_ids
  acts_as_taggable

  has_many :gallery_items, as: :item, dependent: :destroy
  has_many :galleries, through: :gallery_items, source: "MobileApp"

  has_many :mobile_app_agencies, dependent: :destroy
  has_many :agencies, :through => :mobile_app_agencies
  
  has_many :mobile_app_users, dependent: :destroy
  has_many :users, :through => :mobile_app_users

  has_many :mobile_app_versions, :dependent => :destroy

  has_many :mobile_app_official_tags, dependent: :destroy
  has_many :official_tags, :through => :mobile_app_official_tags

  
  accepts_nested_attributes_for :mobile_app_versions, reject_if: :all_blank, allow_destroy: true

  validates :name, :presence => true
  validates :agencies, :length => { :minimum => 1, :message => "have at least one sponsoring agency" } 
  validates :users, :length => { :minimum => 1, :message => "have at least one contact" }
  validates :mobile_app_versions, :length => { :minimum => 1, :message => "have at least one mobile app version" } 
  

  def self.platform_counts
    joins(:mobile_app_versions).where("mobile_apps.draft_id IS NULL").group(:platform).distinct("mobile_app_id, platform").count
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << (column_names + ["agencies" ,"contacts" ,"tags"])

      self.all.includes(:agencies,:users,:official_tags).each do |outlet|
        csv << (outlet.attributes.values_at(*column_names) + [outlet.agencies.map(&:name).join("|") ,outlet.users.map(&:email).join("|"),outlet.official_tags.map(&:tag_text).join("|")])
      end
    end
  end

  def tag_tokens=(ids)
    self.official_tag_ids = ids.split(',')
  end

  def agency_tokens=(ids)
    self.agency_ids = ids.split(',')
  end

  def user_tokens=(ids)
    self.user_ids = ids.split(',')
  end

  def published!
    MobileApp.public_activity_off
    self.status = MobileApp.statuses[:published]
    self.published.destroy! if self.published
    ma = MobileApp.new({
      name: self.name,
      short_description: self.short_description,
      long_description: self.long_description,
      icon_url: self.icon_url,
      language: self.language,
      agency_ids: self.agency_ids || [],
      user_ids: self.user_ids || [],
      official_tag_ids: self.official_tag_ids || [],
      status: self.status,
      draft_id: self.id
    })
    self.mobile_app_versions.each do |mav|
      ma.mobile_app_versions << MobileAppVersion.new(mav.attributes.except!("id","mobile_app_id"))
    end
    ma.save(validate: false)
    self.save(validate: false)
    MobileApp.public_activity_on
    self.create_activity :published
  end
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  short_description :text(65535)
#  long_description  :text(65535)
#  icon_url          :string(255)
#  language          :string(255)
#  agency_id         :integer
#  status            :integer          default("0")
#  mongo_id          :string(255)
#  draft_id          :integer
#
  def archived!
    MobileApp.public_activity_off
    self.status = MobileApp.statuses[:archived]
    self.published.destroy! if self.published
    self.save(validate: false)
    MobileApp.public_activity_on
    self.create_activity :archived
  end

  def publish_requested!
    MobileApp.public_activity_off
    self.status = MobileApp.statuses[:publish_requested]
    self.save!
    MobileApp.public_activity_on
    self.create_activity :publish_requested
  end

  def archive_requested!
    MobileApp.public_activity_off
    self.status = MobileApp.statuses[:archive_requested]
    self.save!
    MobileApp.public_activity_on
    self.create_activity :archive_requested
  end
 
end
