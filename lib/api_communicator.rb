require 'rest-client'
require 'json'
require 'pry'

def get_json(json)
  response_string = RestClient.get(json)
  response_hash = JSON.parse(response_string)
  response_hash
end

#make the web request
def find_character(character_name, json)
  #response_hash = get_json(json)
  movie = json["results"].find do |item|
    item["name"].downcase == character_name
  end
  movie
end

def get_character_movies_from_api(character_name)
  json = get_json('http://www.swapi.co/api/people/')
  movie = find_character(character_name, json)
  while movie.nil?
    json = get_json(json["next"])
    movie = find_character(character_name, json)
  end
  return movie["films"]
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  movie_list = films.map do |film|
    response_string = RestClient.get(film)
    response_hash = JSON.parse(response_string)
    "#{films.index(film) + 1} #{response_hash["title"]}"
  end

  puts movie_list

end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
