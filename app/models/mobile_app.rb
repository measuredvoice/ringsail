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
#

class MobileApp < ActiveRecord::Base
  #handles logging of activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  enum status: { submitted: 0, published: 1, archived: 2 }

  #attr_accessible :name, :shortname, :info_url, :agency_contact_ids
  acts_as_taggable

  has_many :gallery_items, as: :item
  has_many :galleries, through: :gallery_items, source: "MobileApp"

  has_many :mobile_app_agencies
  has_many :agencies, :through => :mobile_app_agencies
  
  has_many :mobile_app_users
  has_many :users, :through => :mobile_app_users

  has_many :mobile_app_versions, :dependent => :destroy

  has_many :mobile_app_official_tags
  has_many :official_tags, :through => :mobile_app_official_tags

  has_paper_trail :ignore => [:status]
  
  accepts_nested_attributes_for :mobile_app_versions, reject_if: :all_blank, allow_destroy: true

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |outlet|
        csv << outlet.attributes.values_at(*column_names)
      end
    end
  end

   def tag_tokens=(ids)
    self.official_tag_ids = ids.split(',')
  end
end
