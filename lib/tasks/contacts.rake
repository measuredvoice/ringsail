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

end
