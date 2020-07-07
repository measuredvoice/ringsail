namespace :contacts do

  task :populate => :environment do
    PublicActivity.enabled = false
    [
      ['justin.herman@gsa.gov','General Services Administration (GSA)'],
      ['Howard.Parnell@fcc.gov','Federal Communications Commission (FCC)'],
      ['Orquina.Jessica@epamail.epa.gov','Environmental Protection Agency (EPA)'],
      ['Erie.Meyer@cfpb.gov','Consumer Financial Protection Bureau '],
      ['Todd.Solomon@dot.gov','Department of Transportation (DOT)'],
      ['LEAHTB@dni.gov','Office of the Director of National Intelligence (DNI)'],
      ['LEAHTB@dni.gov','Information Sharing Environment (ISE)']
    ].each do |contact|
      agency = Agency.find_by_name(contact[1])
      user = User.find_by(email: contact[0])
      if user == nil
        user = User.create(email: contact[0], user: contact[0], agency: agency)
      end
      agency.mobile_apps.each do |ma|
        if !ma.users.map(&:id).include? user.id
          ma.users << user
        end
        ma.save
      end

      agency.outlets.each do |outlet|
        if !outlet.users.map(&:id).include? user.id
          outlet.users << user
        end
        outlet.save
      end

      agency.galleries.each do |gallery|
        if !gallery.users.map(&:id).include? user.id
          gallery.users << user
        end
        gallery.save
      end
    end
  end

  task :cleanup => :environment do
    PublicActivity.enabled = false
    user_emails = User.select(:email).map(&:email).uniq
    user_emails.each do |email|
      puts "Cleaning User Email: #{email}"
      user_accounts_by_email = User.where(email: email)
      if user_accounts_by_email.count > 1
        puts "User: #{email} has #{user_accounts_by_email.count} accounts currently, reducing to 1"
        primary_account = user_accounts_by_email[0]
         puts "User: #{email} primary account has id #{primary_account.id}"
        user_accounts_by_email[1..user_accounts_by_email.count-1].each do |other_account|
          puts "User: #{email} account_id: #{other_account.id} is being redirected to #{primary_account.id}"
          GalleryUser.where(user_id: other_account.id).update(user_id: primary_account.id)
          OutletUser.where(user_id: other_account.id).update(user_id: primary_account.id)
          MobileAppUser.where(user_id: other_account.id).update(user_id: primary_account.id)
          other_account.destroy!
        end
      else
        puts "User: #{email} only has 1 account."
      end

    end

  end
end
