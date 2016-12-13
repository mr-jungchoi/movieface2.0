# Seed data
movies = []
f = File.open('movies.txt', 'r')

f.each_line do |line|
  title = line.gsub(/\d+\. (.+) .+/, '\1').chomp
  movies << title
end
