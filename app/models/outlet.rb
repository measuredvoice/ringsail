# == Schema Information
#
# Table name: outlets
#
#  id            :integer(4)      not null, primary key
#  service_url   :string(255)
#  organization  :string(255)
#  info_url      :string(255)
#  account       :string(255)
#  language      :string(255)
#  updated_by    :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  service       :string(255)
#  location_id   :integer(4)
#  location_name :string(255)
#

class Outlet < ActiveRecord::Base
  #handles logging of activity
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  #handles versioning
  has_paper_trail 
  #attr_accessor :auth_token
  #attr_accessible :service_url, :organization, :info_url, :language, :account, :service, :auth_token, :agency_ids, :tag_list, :location_id, :location_name

  has_many :sponsorships
  has_many :agencies, :through => :sponsorships

  acts_as_taggable
  
  validates :service_url, 
    :presence   => true, 
    :format     => { :with => URI::regexp(%w(http https)) }, 
    :uniqueness => { :case_sensitive => false }
  validates :info_url,
    :format     => { :with => URI::regexp(%w(http https)), 
                     :allow_blank => true}
  validates :agencies, :presence => true
  validates :account, :presence => true
  validates :language, :presence => true
  
  # before_save :set_updated_by
  before_save :fix_service_info
  before_save :clear_agency_counts
  before_destroy :clear_agency_counts
  
  paginates_per 100
  
  def self.to_review
    where('outlets.updated_at < ?', 6.months.ago).order('outlets.updated_at')
  end
  
  def self.to_review_for(email)
    to_review.updated_by(email)
  end
  
  def self.updated_by(email)
    where(:updated_by => email)
  end
  
  def self.emails_for_review
    to_review.group("updated_by").map(&:updated_by).sort
  end
  
  def self.resolve(url)
    return nil if url.nil? or url.empty?

    url = 'http://' + url unless url =~ %r{(?i)\Ahttps?://}
    
    s = Service.find_by_url(url)
    
    return nil unless s
    
    existing = self.find_by_account_and_service(s.account, s.shortname)
    if existing
      return existing
    else
      self.new(:service_url => s.service_url_canonical, :service => s.shortname, :account => s.account)
    end
  end    
  
  def verified?
    # TODO:
    #  Add a more formal definition of a verified outlet
    agencies.size > 0
  end
  
  def service_info
    @service_info ||= Service.find_by_url(service_url)
  end
  
  def masked_updated_by
    (updated_by || '').gsub(/(\w)\w+@/, '\1*****@')
  end
  
  def contact_emails
    agencies.flat_map do |agency|
      agency.contact_emails(:excluding => updated_by)
    end
  end
  
  def history
    @versions = PaperTrail::Outlets.order('created_at DESC')
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
  
  def fix_service_info
    self.service = service_info.shortname
    self.account = service_info.account
  end
  
  def set_location_name
    if (self.location_id_changed?)
      location = OutletLocation.find_by_id(location_id)
      if location
        self.location_name = location.display_name
      else
        self.location_name = nil
      end
    end
  end
  
  def clear_agency_counts
    agencies.each do |agency|
      agency.clear_outlets_count
    end
  end
end
