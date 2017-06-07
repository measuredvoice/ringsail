class AddOmbMaxAgencyTitle < ActiveRecord::Migration
  def change
    add_column :agencies, :omb_name, :string

    Agency.all.each do |agency|
      agency.omb_name = agency.name
      agency.save!(validate: false)
    end
  end
end
