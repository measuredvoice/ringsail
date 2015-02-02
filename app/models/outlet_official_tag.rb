class OutletOfficialTag < ActiveRecord::Base
  belongs_to :outlet
  belongs_to :official_tag, counter_cache: :outlet_count
end
