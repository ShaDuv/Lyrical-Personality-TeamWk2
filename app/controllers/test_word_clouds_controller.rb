require 'word_cloud'

class TestWordCloudsController < ApplicationController
  def show_input
    render :input
  end
  def get_input
    word_cloud = WordCloud.new(params[:input_text])
    @tag_array = word_cloud.tag_array
    render :output
  end
end
