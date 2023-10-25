class Show
  TIME_MAP_ENDPOINT_URL = "https://api.mixcloud.com/patternradio/cloudcasts".freeze

  # def initialize(location:, transportation_type:, travel_time_in_minutes:)
  #   @location = location
  #   @transportation_type = transportation_type
  #   @travel_time_in_minutes = travel_time_in_minutes
  # end

  def travel_area
    response
  end

  private

  def response
    HTTParty.get(TIME_MAP_ENDPOINT_URL, headers: headers)
  end

  def headers
    {
      "Content-Type": "application/json",
    }
  end

  def payload
    {}
  end
end