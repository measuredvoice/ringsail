include Yahoo::GeoPlanet
Yahoo::GeoPlanet.app_id = ENV['YAHOO_APP_ID']

class OutletLocation
  attr_accessor :woe_id
  attr_reader :location_type, :city, :state, :country, :longitude, :latitude
  
  # Class methods
  
  def self.find_by_text(query_text)
    Place.search(query_text).flat_map do |place|
      # Ignore place types we don't know how to handle
      case place.type
      when 'Town', 'State', 'Province', 'Point of Interest', 'Country', 'District', 'Territory'
        self.new(place.woe_id, place)
      else
        []
      end
    end
  end
  
  def self.find_by_id(woe_id)
    return nil unless woe_id
    
    place = Place.new(woe_id)
    
    if (place)
      self.new(place.woe_id, place)
    end
  end
  
  def initialize(woe_id, place)
    @woe_id = woe_id
    @place = place
    @location_type = place.type
    @latitude = place.latitude
    @longitude = place.longitude
    @city = place.yfields['town']
    @state = place.yfields['state'] || place.yfields['province'] || place.yfields['district']
    @country = place.yfields['country'] || place.yfields['territory']
  end
    
  # Instance methods
  
  def display_name
    case @location_type
    when 'Point of Interest'
      "#{@place.to_s}, #{@city}, #{@state}"
    when 'State', 'Province'
      case @country
      when "United States"
        "State of #{@state}"
      else
        "#{@location_type} of #{@state}, #{@country}"
      end
    when 'Town'
      case @country
      when "United States"
        "#{@city}, #{@state}"
      when "Canada", "Australia"
        "#{@city}, #{@state}, #{@country}"
      else
        "#{@city}, #{@country}"
      end
    else
      @place.to_s
    end
  end
end
