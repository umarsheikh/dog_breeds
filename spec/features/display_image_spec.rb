require 'rails_helper'

RSpec.feature 'Dogs', js: true do
  let(:image_url) { 'http://example.com/labrador.jpg' }
  let(:expected_response) { instance_double(HTTParty::Response, success?: true, parsed_response: { 'message' => image_url }) }

  scenario 'User enters a breed name and clicks the Fetch button to see the image' do
    WebMock.allow_net_connect!
    allow_any_instance_of(DogsApiService).to receive(:fetch_image).with('labrador').and_return(expected_response)

    visit new_dog_path

    fill_in 'breed', with: 'labrador'
    click_button 'Fetch'

    expect(page).to have_css('img[src="http://example.com/labrador.jpg"]')
  end
end
