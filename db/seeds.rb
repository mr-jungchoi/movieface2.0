movies = []
f = File.open('movies.txt', 'r')

f.each_line do |line|
  title = line.gsub(/\d+\. (.+) .+/, '\1').chomp

  movies << title
end

movies.each do |title|
  movie = Movie.find_by_title(title)
  
  if movie == nil
    omdb_response = open("http://www.omdbapi.com/?y=&plot=short&r=json&t=#{title}").read
    youtube_response = open("https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&q=#{title}+trailer&key=#{Dotenv.load["YOUTUBE_TOKEN"]}").read
    movie = Movie.parse(youtube_response, omdb_response)
    movie_genre = Genre.parse(omdb_response)
    genre = Genre.find_or_create_by(name: movie_genre.name)
    movie.genre = genre
    movie.save
  end
end
