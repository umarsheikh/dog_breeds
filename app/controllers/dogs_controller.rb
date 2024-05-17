class DogsController < ApplicationController
  def new
  end

  def create
    response = DogsApiService.new.fetch_image(params[:breed])
    if response.success?
      @image_url = response['message']
    else
      @error = response['message']
    end
    render_iamge
  end

  private

  def render_iamge
    render turbo_stream:
      turbo_stream.replace(
        "breed_image",
        partial: 'dogs/breed_image'
      )
  end
end
