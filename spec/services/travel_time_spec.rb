require "rails_helper"

RSpec.describe TravelTime do
  subject { described_class.new(location: location, transportation_type: transportation_type, travel_time_in_minutes: travel_time) }

  let(:location) { "SW1P 3BT" }
  let(:transportation_type) { "public_transport" }
  let(:travel_time) { "5" }

  describe "#travel_area" do
    let(:travel_area) { subject.travel_area }
    let(:response) { JSON.parse(file_fixture("travel_time.json").read) }
    let(:first_polygon_in_response) { response["results"].first["shapes"].first["shell"].map { |point| point.values } }
    let(:first_polygon_in_travel_area) { travel_area.coordinates.first.first }

    before { allow(HTTParty).to receive(:post).and_return(response) }

    it "returns a travel area poylgon" do
      expect(subject.travel_area).to be_instance_of(RGeo::Geographic::SphericalMultiPolygonImpl)
      expect(first_polygon_in_travel_area).to eq(first_polygon_in_response)
    end
  end
end