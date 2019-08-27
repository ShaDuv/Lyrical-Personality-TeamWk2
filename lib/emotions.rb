require "ibm_watson/tone_analyzer_v3"
require 'json'

class Emotions
  attr_reader :scores
  def initialize(lyrics_string)
    @anger_score = 0
    @anger_count = 0
    @fear_score = 0
    @fear_count = 0
    @joy_score = 0
    @joy_count = 0
    @sadness_score = 0
    @sadness_count = 0
    tone_analyzer = IBMWatson::ToneAnalyzerV3.new(
      iam_apikey: ENV['TONE_KEY'],
      version: "2017-09-21"
    )
    @response = (tone_analyzer.tone(
      tone_input: lyrics_string,
      content_type: "text/plain"
    ).result)
  end
  def calc_joy
    @response['sentences_tone'].each do |sentence|
      if sentence.any?
        sentence['tones'].each do |tone|
          if tone['tone_id'] == 'joy'
            @joy_score += tone['score']
            @joy_count += 1
          end
        end
      end
    end
    if @joy_count != 0
      @joy_score/@joy_count
    else
      "0"
    end
  end
  def calc_anger
    @response['sentences_tone'].each do |sentence|
      if sentence.any?
        sentence['tones'].each do |tone|
          if tone['tone_id'] == 'anger'
            @anger_score += tone['score']
            @anger_count += 1
          end
        end
      end
    end
    if @anger_count != 0
      @anger_score/@anger_count
    else
      "0"
    end
  end
  def calc_fear
    @response['sentences_tone'].each do |sentence|
      if sentence.any?
        sentence['tones'].each do |tone|
          if tone['tone_id'] == 'fear'
            @fear_score += tone['score']
            @fear_count += 1
          end
        end
      end
    end
    if @fear_count != 0
      @fear_score/@fear_count
    else
      "0"
    end
  end
  def calc_sadness
    @response['sentences_tone'].each do |sentence|
      if sentence.any?
        sentence['tones'].each do |tone|
          if tone['tone_id'] == 'sadness'
            @sadness_score += tone['score']
            @sadness_count += 1
          end
        end
      end
    end
    if @sadness_count != 0
      @sadness_score/@sadness_count
    else
      "0"
    end
  end
end
