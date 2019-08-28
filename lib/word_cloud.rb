class WordCloud
  def initialize(text)
    @word_frequencies = Hash.new { |hash, key| hash[key] = 0 }
    text.split(/\s/).each { |word| @word_frequencies[word] += 1 }
  end

  def tag_array
    tags = []
    @word_frequencies.each_pair do |word, freq|
      tags.push({ text: word, weight: freq })
    end
    tags
  end


end
