require 'rest_client'
require 'json'
require 'mechanize'
require 'byebug'
require 'webdrivers'
require 'watir'
class Lyrics
  # This function takes user input and puts it in an array to be passed into our lyrics_by_artist function. To search with multiple artists the input needs to be seperated by a ","
  def self.user_input_to_array(user_input_as_string)
    output_array = user_input_as_string.split(",")
    output_array.each do |artist|
      artist.strip!
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
          track = parsed_response["results"][num]["trackName"]
          track.tr!(",''", "")
          mechanize = Mechanize.new
          # go to genius page with lyrics
          browser = Watir::Browser.new :chrome, headless: true
          browser.goto("https://genius.com/search?q=#{artist}#{track}")
          browser.link(:class => "mini_card").when_present.click
          page = mechanize.get(browser.url)
          # gather lyrics from page and format for search
          lyrics += page.search('p').first.text.gsub(/\[.+?\]/, '').split(/(?=[A-Z])/).join(" ") + " "

          #new stuff
          # browser = Watir::Browser.new :chrome, headless: true
          # browser.goto("https://genius.com/search?q=#{artist}#{track}")
          # browser.link(:class => "mini_card").when_present.click
          # # gather lyrics from page and format for search
          # lyrics += browser.p.text.gsub(/\[.+?\]/, '').split(/(?=[A-Z])/).join(" ") + " "
        end
      end
    end
    #return lyrics
    lyrics
  end
end


puts Lyrics.lyrics_by_artist(Lyrics.user_input_to_array("alice in chains"))


# https://www.chrismytton.uk/2015/01/22/advanced-web-scraping-with-mechanize/

#target an href value page.search("a")[10].attributes["href"].text
