require_relative'test_helper'
require'./lib/game'

class GameTest < Minitest::Test

	def test_game_exists
		game = Game.new
		assert_instance_of Game, game
	end

  def test_answer
    game = Game.new(100)
    assert_equal 100,  game.answer
  end

  def test_guess_that_is_too_low
    game = Game.new(50)

    assert_equal "You have made 1 guess(es)\nYour guess was 32, which is too low.", game.make_a_guess("32")
  end

  def test_guess_that_is_too_high
    game = Game.new(99)

    assert_equal "You have made 1 guess(es)\nYour guess was 201, which is too high.", game.make_a_guess("201")
  end

  def test_correct_guess
    game = Game.new(22)
    result = "You have made 1 guess(es)\nYour guess was 22, which is correct!"

    assert_equal result, game.make_a_guess("22")
  end

  def test_guess_counter
  game = Game.new(88)

    game.make_a_guess("22")
    game.make_a_guess("99")
    game.make_a_guess("73")
    game.make_a_guess("1")
    game.make_a_guess("88")

    assert_equal 5, game.guess_counter
  end
end