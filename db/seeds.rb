movies = []
f = File.open('movies.txt', 'r')

f.each_line do |line|
  title = line.gsub(/\d+\. (.+) .+/, '\1').chomp
  movies << title
end

movies.each do |title|
  omdb_response = open(omdb_url + title).read
  youtube_response = open(youtube_url + trailer_search(title) + youtube_token).read
  movie = Movie.parse(youtube_response, omdb_response)
  movie_genre = Genre.parse(omdb_response)
  genre = Genre.find_or_create_by(name: movie_genre.name)
  movie.genre = genre
  movie.save
end

private

def youtube_url
  "https://www.googleapis.com/youtube/v3/search?part=snippet&q="
end

def omdb_url
  "http://www.omdbapi.com/?y=&plot=short&r=json&t="
end

def trailer_search(movie_name)
  "#{movie_name}+trailer"
end
