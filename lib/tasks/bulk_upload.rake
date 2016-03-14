namespace :bulk_upload do
  desc "load formatted CSV data into system for outlets"
  task :outlets_csv, [:file] => :environment do |t, args|
    begin
      PublicActivity.enabled = false
      filepath = args[:file]
      raise 'No file path specified'  if filepath == nil 
      raise "No file found at #{filepath}" if !File.exists?(filepath)
      total_valid_rows = 0
      empty_row_count = 0
      invalid_accounts = 0
      valid_accounts = 0
      CSV.foreach(filepath, :headers=> true, :header_converters => :symbol , :encoding => 'windows-1251:utf-8') do |row, i|
        if row[:service_type] #if row actually has data, because CSVs are wonky
          total_valid_rows += 1
          if Admin::Service.find_by_shortname(row[:service_type].downcase.strip.gsub(" ","_")) #&&
            outlet = Outlet.find_or_initialize_by({service_url: row[:account_url], draft_id: nil})
            agencies = []
            if row[:sponsoring_agencies]
              row[:sponsoring_agencies].split(',').each do |agency|
                agency =  Agency.find_by(name: agency.strip)
                agencies << agency if agency
              end
            end
            # puts agencies.inspect
            tags = []
            if row[:tags]
              row[:tags].split(',').each do |tag|
                tag= OfficialTag.find_or_create_by(tag_text: tag.strip)
                tags << tag if tag
              end
            end
            users = []
            if row[:contacts]
              row[:contacts].split(",").each do |user_email|
                user = User.find_or_initialize_by(email: user_email.strip)
                user.user = user_email.strip
                user.save
                users << user if user
              end
            end
            # puts row.inspect
            outlet.update({
                :service => row[:service_type].downcase.strip.gsub(" ","_"),
                :service_url => row[:account_url],
                :account => Admin::Service.find_by_url(row[:account_url]) ? Admin::Service.find_by_url(row[:account_url]).account : nil,
                :organization => row[:account_name],
                :short_description => row[:short_description],
                :long_description => row[:long_description],
                :language => row[:language]
              })
            
            outlet.save(validate: false)
            outlet.agencies = agencies
            outlet.official_tags = tags
            outlet.users = users;
            # puts outlet.inspect
            outlet.save(validate: false)
            outlet.published!
            valid_accounts += 1
          else
            puts "************INVALID #{row[:service_type].downcase.gsub(" ","_")}"
            puts "Current Row Line: #{$.}"
            invalid_accounts +=1
          end
          # puts "Current Row Line: #{$.}" #yes this is magic, welcome to ruby
        else
          empty_row_count += 1
        end
      end
      puts "Total rows read with data: #{total_valid_rows}"
      puts "Valid accounts: #{valid_accounts}"
      puts "Invalid accounts: #{invalid_accounts}"
    rescue Exception => e
      puts "There was an error: #{e}"
      raise e
    end
  end

end
