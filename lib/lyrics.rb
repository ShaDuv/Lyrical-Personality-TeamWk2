require 'rest_client'
require 'json'
require 'mechanize'
require 'byebug'

class Lyrics
  # This function takes user input and puts it in an array to be passed into our lyrics_by_artist function. To search with multiple artists the input needs to be seperated by a ","
  def self.user_input_to_array(user_input_as_string)
    output_array = user_input_as_string.split(",")
    output_array.each do |artist|
      artist.strip!
      artist.tr!(" ", "-")
    end
  end

  #This function takes an array of strings as an argument
  def self.lyrics_by_artist(artist_array)
    lyrics = ""

    if artist_array.any? && artist_array.length <= 1

      artist_array.each do |artist|
        response = RestClient::Request.execute(
          method: :get,
          url: "https://itunes.apple.com/search?term=#{artist}",
        )
        parsed_response = JSON.parse(response)

        10.times do |num|
          sleep 0.05
          # name of song
          track = parsed_response["results"][num]["trackName"].tr(" ", "-")
          track.tr!(",''", "")
          # scrape the first result of a google search
          mechanize = Mechanize.new
          # go to genius page with lyrics
          page = mechanize.get("https://genius.com/lyrics/#{artist}/#{track}")
          # gather lyrics from page and format for search
          lyrics += page.search('p').first.text.gsub(/\[.+?\]/, '').split(/(?=[A-Z])/).join(" ") + " "
        end
      end
    end
    #return lyrics
    lyrics
  end
end

# this will print all lyrics from the top 10 alice in chains songs
# puts Lyrics.lyrics_by_artist(Lyrics.user_input_to_array("alice in chains"))
