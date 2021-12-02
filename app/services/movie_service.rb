class MovieService
  def self.popular_movies

    conn = Faraday.new("https://api.themoviedb.org")
    response = conn.get("3/movie/popular?api_key=#{ENV['movie_api_key']}&language=en-US&page=1")

    JSON.parse(response.body, symbolize_names: true)
  end
end
