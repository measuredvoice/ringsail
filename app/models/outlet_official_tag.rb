# == Schema Information
#
# Table name: outlet_official_tags
#
#  id              :integer          not null, primary key
#  outlet_id       :integer
#  official_tag_id :integer
#

class OutletOfficialTag < ActiveRecord::Base
  belongs_to :outlet
  belongs_to :official_tag, counter_cache: :outlet_count
  has_paper_trail 
end
