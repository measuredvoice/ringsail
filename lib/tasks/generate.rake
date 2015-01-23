namespace :generate_data do
  desc "Fill database with basic data"
  task :generate => :environment do
    agencies = Agency.order(name: :asc).page(0).per(25)
    tags = ActsAsTaggableOn::Tag.order(name: :asc).page(0).per(25)
    outlets = Outlet.order(organization: :asc).page(0).per(25)

    json_object = []
    (0..24).each do |item|
    	json_object << {id: "agency_id:#{agencies[item].id}", name: agencies[item].name }
    	json_object << {id: "tag_id:#{tags[item].id}", name: tags[item].name }
    	json_object << {id: "outlet_id:#{outlets[item].id}", name: outlets[item].organization }
    end

    File.open("testdata.json", 'w') { |file| file.write(json_object.to_json) }
  end
end
