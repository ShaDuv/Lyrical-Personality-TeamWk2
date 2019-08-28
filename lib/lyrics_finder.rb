require 'rest-client'

class LyricsFinder
  attr_reader :lyrics
  def initialize(artist)
    @lyrics = ""
    # Get artist_id
    artist_id = nil
    json_response = JSON.parse RestClient::Request.execute(
      method: :get,
      url: "https://api.musixmatch.com/ws/1.1/artist.search?q_artist=#{artist}&apikey=#{ENV['MUSIXMATCH_APIKEY']}"
    )
    # File.write('artist_search.json', JSON.pretty_generate(json_response))
    artists = json_response['message']['body']['artist_list']
    if artists.any?
      artist_id = artists[0]['artist']['artist_id']
    end
    if artist_id
      # get album ids
      json_response = JSON.parse RestClient::Request.execute(
        method: :get,
        url: "https://api.musixmatch.com/ws/1.1/artist.albums.get?artist_id=#{artist_id}&apikey=#{ENV['MUSIXMATCH_APIKEY']}"
      )
      # File.write('album_search.json', JSON.pretty_generate(json_response))
      albums = json_response['message']['body']['album_list']
      if albums.any?
        album_ids = albums.map do |obj|
          obj["album"]["album_id"]
        end
        # get track ids for each album
        track_ids = []
        album_ids.each do |album_id|
          json_response = JSON.parse RestClient::Request.execute(
            method: :get,
            url: "https://api.musixmatch.com/ws/1.1/album.tracks.get?album_id=#{album_id}&apikey=#{ENV['MUSIXMATCH_APIKEY']}"
          )
          # File.write("lyrics_search_#{album_id}.json", JSON.pretty_generate(json_response))
          json_response['message']['body']['track_list'].each do |obj|
            track_ids.push(obj['track']['track_id'])
          end
        end
        # get lyrics for each track
        track_ids.each do |track_id|
          json_response = JSON.parse RestClient::Request.execute(
            method: :get,
            url: "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=#{track_id}&apikey=#{ENV['MUSIXMATCH_APIKEY']}"
          )
          # File.write("lyrics_search_.json", JSON.pretty_generate(json_response))
          @lyrics += json_response['message']['body']['lyrics']['lyrics_body']
          @lyrics.sub!("******* This Lyrics is NOT for Commercial use *******", "")
        end
      else
        @lyrics = nil
      end
    else
      @lyrics = nil
    end
  end
end
