require 'rails_helper'

RSpec.describe DogsApiService do
  describe '#fetch_image' do
    let(:service) { DogsApiService.new }
    let(:breed) { 'african' }
    let(:response_body) { { 'message' => 'https://example.com/african.jpg', 'status' => 'success' }.to_json }

    before do
      stub_request(:get, "https://dog.ceo/api/breed/#{breed.downcase}/images/random")
        .to_return(status: 200, body: response_body, headers: {'Content-Type': 'application/json'})
    end

    it 'fetches image for the given breed' do
      response = service.fetch_image(breed)

      expect(response.parsed_response['status']).to eq('success')
      expect(response.parsed_response['message']).to include(breed)
    end
  end
end
