atom_feed(:root_url => list_outlets_url) do |feed|
  feed.title "U.S. Government Social Media Registry Accounts"

  last_account = @outlets.first
  feed.updated( last_account && last_account.updated_at )

  @outlets.each do |outlet|
    howto_review_url = howto_find_outlet_url(:service_url => outlet.service_url, :host => ENV['RINGSAIL_HOST'])
    feed.entry(outlet, :url => howto_review_url, :published => outlet.updated_at ) do |entry|
      if outlet.updated_at == outlet.created_at
        entry.title "New #{outlet.service} account: #{outlet.account}"
      else
        entry.title "Updated #{outlet.service} account: #{outlet.account}"
      end
            
      if outlet.updated_at == outlet.created_at
        posted = 'Added'
      else
        posted = 'Updated'
      end
      entry.summary( 
        "<p>Account URL: <a href=\"#{outlet.service_url}\"><strong>#{outlet.service_url}</strong></a><br>" +
        "#{posted} on: <strong>#{outlet.updated_at.to_s(:human)}</strong><br>" +
        "#{posted} by: <strong>#{outlet.updated_by.gsub(/(\w)\w+@/, '\1*****@')}</strong></p>" +

        "<p>Organization or program: <strong>#{outlet.organization}</strong><br>" +
        "Program URL: <strong>#{outlet.info_url}</strong><br>" +
        "Sponsoring top-level #{pluralize_word(outlet.agencies.count, 'Agency')}: <strong>#{outlet.agencies.join(", ")}</strong><br>" +
        "Tags: <strong>#{outlet.tag_list.join(", ")}</strong><br>" +
        "Language: <strong>#{outlet.language}</strong></p>" +
        
        "<p><a href=\"#{howto_review_url}\"><strong>Review on HowTo.gov</strong></a></p>",
        :type => 'html')

      entry.author do |author|
        author.name outlet.updated_by.gsub(/(\w)\w+@/, '\1*****@')
      end
    end
  end
end
