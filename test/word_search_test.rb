require'./test/test_helper'
require'./lib/word_search'

class WordSeachTest < Minitest::Test
  def test_dictionary_includes_known_words
    word_search = WordSearch.new
    assert word_search.is_word?("hello")
    assert word_search.is_word?("another")
  end

	def test_can_refute_unknown_words
		word_search = WordSearch.new

		refute word_search.is_word?("Ba123nana")
		refute word_search.is_word?("bananza")
		refute word_search.is_word?("bananarama")
	end

	def test_returns_known_word
    word_search = WordSearch.new

    result = "HELLO is a word"
    assert_equal result, word_search.word_search(["hello"])
	end

  def test_returns_unknown_word
    word_search = WordSearch.new

    result = "BAKARA is not a word"
    assert_equal result, word_search.word_search(["Bakara"])
  end

  def test_returns_multiple_known_words
    word_search = WordSearch.new

    result = "HELLO is a word\nWORD is a word\nPIZZA is a word"
    assert_equal result, word_search.word_search(["hello", "word", "pizza"])
  end

  def test_returns_combination_of_known_and_unknown_words
    word_search = WordSearch.new

    result = "HELLO is a word\nARDVARKDAR is not a word\nPIZZA is a word"
    assert_equal result, word_search.word_search(["hello", "ARDVARKDAR", "pizza"])
  end
end