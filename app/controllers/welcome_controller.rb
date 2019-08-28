require 'lyrics'
require 'personality_traits'
require 'emotions'

class WelcomeController < ApplicationController
  def index
    render :index
  end

  def get_results
    user_input = params[:search]
    lyrics = Lyrics.lyrics_by_artist(Lyrics.user_input_to_array(user_input))
    personality_traits = PersonalityTraits.new(lyrics)
    @personality_percents = personality_traits.percents
    emotions = Emotions.new(lyrics)
    @joy = (emotions.calc_joy * 100).round(0)
    @anger = (emotions.calc_anger * 100).round(0)
    @fear = (emotions.calc_fear * 100).round(0)
    @sadness = (emotions.calc_sadness * 100).round(0)
    render :index
  end
end
