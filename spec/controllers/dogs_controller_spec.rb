require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  render_views

  describe 'POST #create' do
    context 'when the API request is successful' do
      let(:breed) { 'labrador' }
      let(:image_url) { 'https://example.com/labrador.jpg' }
      let(:expected_response) { instance_double(HTTParty::Response, success?: true, parsed_response: { 'message' => image_url }) }

      before do
        allow_any_instance_of(DogsApiService).to receive(:fetch_image).with(breed).and_return(expected_response)
        post :create, params: { breed: breed }
      end

      it 'assigns the image URL' do
        expect(assigns(:image_url)).to eq(image_url)
      end

      it 'renders breed_image partial via turbo_stream' do
        expect(response).to have_http_status(:success)
        expect(response).to render_template(layout: false)
        expect(response).to render_template('dogs/_breed_image')
        expect(response.body).to include(image_url)
      end
    end

    context 'when the API request fails' do
      let(:breed) { 'nonexistent' }
      let(:error_message) { 'Breed not found' }
      let(:expected_response) { instance_double(HTTParty::Response, success?: false, parsed_response: { 'message' => error_message }) }

      before do
        allow_any_instance_of(DogsApiService).to receive(:fetch_image).with(breed).and_return(expected_response)
        post :create, params: { breed: breed }
      end

      it 'assigns the error message' do
        expect(assigns(:error)).to eq(error_message)
      end

      it 'renders breed_image partial via turbo_stream' do
        expect(response).to have_http_status(:success)
        expect(response).to render_template(layout: false)
        expect(response).to render_template('dogs/_breed_image')
        expect(response.body).to include(error_message)
      end
    end
  end
end
