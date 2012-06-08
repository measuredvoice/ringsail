atom_feed(:root_url => list_outlets_url) do |feed|
  feed.title "U.S. Government Social Media Registry Accounts"

  last_account = @outlets.first
  feed.updated( last_account && last_account.updated_at )

  @outlets.each do |outlet|
    feed.entry(outlet, :url => show_outlet_url(:service => outlet.service, :account => outlet.account) ) do |entry|
      entry.title "#{outlet.service}: #{outlet.account} (#{outlet.agencies.join("/")})"
      entry.summary type: 'xhtml' do |xhtml|
        if outlet.updated_at == outlet.created_at
          xhtml.p "New entry posted to the registry on: "  + outlet.updated_at.to_s(:human)
        else
          xhtml.p "Entry updated in the registry on: " + outlet.updated_at.to_s(:human)
        end
        xhtml.p "By: " + outlet.updated_by.gsub(/(\w)\w+@/, '\1*****@')
      end
      entry.author do |author|
        author.name outlet.updated_by.gsub(/(\w)\w+@/, '\1*****@')
      end
    end
  end
end