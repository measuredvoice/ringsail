# == Schema Information
#
# Table name: admin_services
#
#  id                         :integer          not null, primary key
#  handles_regex_eval         :string(255)
#  shortname                  :string(255)
#  longname                   :string(255)
#  display_name_eval          :string(255)
#  account_matchers_eval      :text(65535)
#  service_url_example        :string(255)
#  service_url_canonical_eval :string(255)
#  archived                   :boolean          default(FALSE)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

module Admin::ServicesHelper
end
