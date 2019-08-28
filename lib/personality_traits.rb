# In order for this class to work, the following needs to be in .env:
# PERSONALITY_APIKEY={Your API Key, no brakets}

require("json")
require("ibm_watson/personality_insights_v3")

class PersonalityTraits
  attr_reader :percents # Hash for accessing the percents for each personality trait. Keys are the personality traits in all caps: "OPENNESS", Conscientiousness"CONSCIENTIOUSNESS", "EXTRAVERSION", "AGREEABLENESS" and "EMOTIONAL RANGE"

  def initialize(input_string)
    while input_string.split(/\s/).count < 100 do
      input_string += " " + input_string
    end
    personality_insights = IBMWatson::PersonalityInsightsV3.new(
      iam_apikey: ENV['PERSONALITY_APIKEY'],
      version: "2017-10-13"
    )
    profile_result = personality_insights.profile(
      content: input_string,
      content_type: "text/plain",
      accept: "application/json",
      raw_scores: true,
      consumption_preferences: true
    ).result
    @percents = {}
    profile_result["personality"].each do |personality_trait|
      @percents[personality_trait['name'].upcase] = (personality_trait['percentile'] * 100).round(0)
    end
  end
end
