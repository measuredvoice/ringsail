class OfficialTag < ActiveRecord::Base
  attr_accessible :shortname, :tag_text
  
  validates :tag_text, :presence => true
  validates :shortname, :presence => true, :uniqueness => true
  
  before_validation :fix_shortname
  
  private
  
  def fix_shortname
    self.shortname = squish_tag(shortname) || squish_tag(tag_text)
    self.tag_text ||= shortname
  end

  def squish_tag(tag_text='')
    unless tag_text.nil? || tag_text.empty?
      tag_text.downcase.gsub(/\W/,'')
    end
  end
end
