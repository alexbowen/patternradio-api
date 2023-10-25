class TravelTime
  TIME_MAP_ENDPOINT_URL = "https://api.traveltimeapp.com/v4/time-map".freeze

  def initialize(location:, transportation_type:, travel_time_in_minutes:)
    @location = location
    @transportation_type = transportation_type
    @travel_time_in_minutes = travel_time_in_minutes
  end

  def travel_area
    shapes = response["results"] ? response["results"].first["shapes"] : []
    polygons = polygons(shapes)
    factory.multi_polygon(polygons)
  end

  private

  def response
    HTTParty.post(TIME_MAP_ENDPOINT_URL, headers: headers, body: payload.to_json)
  end

  def headers
    {
      "Content-Type": "application/json",
      "X-Application-Id": ENV.fetch("TRAVEL_TIME_APPLICATION_ID", nil),
      "X-Api-Key": ENV.fetch("TRAVEL_TIME_API_KEY", nil),
    }
  end

  def payload
    {
      departure_searches: [
        id: @location,
        coords: location_coordinates,
        transportation: {
          type: @transportation_type
        },
        departure_time: Time.current.iso8601,
        travel_time: @travel_time_in_minutes.to_i * 60
      ]
    }
  end

  def location_coordinates
    coordinates = Geocoder.search(@location).first.coordinates

    { lat: coordinates.first, lng: coordinates.last }
  end

  def polygons(shapes)
    shapes.map do |shape|
      points = factory_points(shape)
      ring = factory.linear_ring(points)
      factory.polygon(ring)
    end
  end

  def factory
    @factory ||= RGeo::Geographic.spherical_factory
  end

  def factory_points(shape)
    shape["shell"].map { |point| factory.point(point["lat"], point["lng"]) }
  end
end