require 'open-uri'

class AppStore

  def self.find_details_by_url(link)
    uri = URI.parse(link)
    if uri.host == "itunes.apple.com"
      id = uri.path.split("/id").last
      details = self.apple_store_data(id)
    elsif uri.host == "play.google.com"
      params = Rack::Utils.parse_nested_query uri.query
      id = params["id"]
      details =  self.google_store_data(id)
    else
      details = {}
    end
    details
  end

  def self.google_store_data(id)
    full_uri = "https://play.google.com/store/apps/details?id=#{id}"
    begin
      response = Nokogiri::HTML(open(full_uri).read)
      details = {
        platform: "Android",
        version: response.xpath('//*[@itemprop="softwareVersion"]/text()').to_s.strip,
        average_rating: response.xpath('//*[@itemprop="aggregateRating"]//meta[@itemprop="ratingValue"]/@content').to_s.strip,
        number_of_ratings: response.xpath('//*[@itemprop="aggregateRating"]//meta[@itemprop="ratingCount"]/@content').to_s.strip,
        screenshot: response.xpath('//img[@itemprop="screenshot"]/@src').map(&:to_s).join("\n")
      }
    rescue Exception => e
      Rails.logger.info e.inspect
      return {}
    end
    details
  end

  def self.apple_store_data(id)
    full_uri = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/wsLookup?mt=8&id=#{id}"
    begin
      response = JSON.parse(open(full_uri).read)
      if response["resultCount"] == 1
        return {
          platform: "iOS",
          version: response["version"],
          average_rating: response["averageUserRating"],
          number_of_ratings: response["userRatingCount"],
          screenshot: response["screenshotUrls"].join("\n"),
          language: response["language"] == "EN" ? "English" : "Spanish"
        }
      else
        return {}
      end
    rescue Exception => e
      Rails.logger.info e.inspect
      return {}
    end
  end 
end