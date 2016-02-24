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

module OutletsHelper
end
