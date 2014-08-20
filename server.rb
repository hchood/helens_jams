require 'sinatra'
require 'sinatra/reloader'
require 'csv'
require 'pry'

# Create pages for:
# - Page that lists all the artists & links to artist's page

# ["Empire of the Sun", "U2", "Jay-Z", "The Neighbourhood", "Interpol"]
def get_artists
  artists = []

  CSV.foreach('songs.csv', headers: true) do |row|
    artist_name = row["Artist"]

    if !artists.include?(artist_name)
      artists << artist_name
    end
  end

  artists
end

# {
#   name: 'U2',
#   genre: 'rock',
#   songs: ['Ultraviolet', 'One']
# }

def get_artist_info(artist_name)
  artist_hash = {}
  artist_hash[:songs] = []

  CSV.foreach('songs.csv', headers: true) do |row|
    if row["Artist"] == artist_name
      artist_hash[:name] = row["Artist"]
      artist_hash[:genre] = row["genre"]
      artist_hash[:songs] << row["Name"]
    end
  end

  artist_hash
end

get '/artists' do
  @artists = get_artists

  erb :'/artists/index'
end

# - Page for each artist.  Has name, genre, and then name of each of their songs

get '/artists/:artist_name' do
  artist_info = get_artist_info(params[:artist_name])

  @artist = artist_info[:name]
  @genre = artist_info[:genre]
  @songs = artist_info[:songs]

  erb :'/artists/show'
end

# - Page that lists all songs
# - Page for each song, showing name of song & artist name
