class WordSearch

  def word_search(words)
    word_arr = words.map do |word|
      if is_word? word
        "#{word.upcase} is a word"
      else
        "#{word.upcase} is not a word"
      end
    end
		word_arr.join("\n")
  end

  def is_word?(word)
    dictionary = File.read("/usr/share/dict/words").split("\n")
    dictionary.include?(word)
  end
end