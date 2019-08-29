require 'lyrics'
require 'emotions'
require 'personality_traits'

class WelcomeController < ApplicationController
  def index
    render :index
  end

  def get_results
    @results = true
    @artist = params[:search]
    lyrics = Lyrics.lyrics_by_artist(Lyrics.user_input_to_array(@artist))
    @personality_percents = PersonalityTraits.new(lyrics).percents
    emotions = Emotions.new(lyrics)
    @joy = (emotions.calc_joy * 100).round(0)
    @anger = (emotions.calc_anger * 100).round(0)
    @fear = (emotions.calc_fear * 100).round(0)
    @sadness = (emotions.calc_sadness * 100).round(0)
    render :index
  end
end
