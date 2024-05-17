class DogsApiService
  def fetch_image(breed)
    url = "https://dog.ceo/api/breed/#{breed.downcase}/images/random"
    HTTParty.get(url)
  end
end
