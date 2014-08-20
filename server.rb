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

get '/artists' do
  @artists = get_artists

  erb :'/artists/index'
end



# - Page for each artist.  Has name, genre, and then name of each of their songs
# - Page that lists all songs
# - Page for each song, showing name of song & artist name
