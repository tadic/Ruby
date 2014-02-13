class BeermappingApi
 
  def self.places_in(city)
    city = city.downcase
    puts city
    Rails.cache.fetch(city,:expires_in => 60.minutes.from_now) { fetch_places_in(city) }
    place = Rails.cache.fetch(city)
   # Rails.cache.write('last_city', Rails.cache.fetch(city))
    Rails.cache.write('last_city', place)
    return Rails.cache.fetch(city) 
  end

  def self.place_with_id(place_id)
   places = Rails.cache.fetch('last_city')
   places.find {|item| item.id == place_id}
  end
  
  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
   #response = HTTParty.get "#{url}#{city}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.key
    #"96ce1942872335547853a0bb3b0c24db"
    Settings.beermapping_apikey
     # "3629bc674993e2621dc22561224cff6b"
  end
end