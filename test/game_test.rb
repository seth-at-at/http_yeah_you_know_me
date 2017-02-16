require_relative'test_helper'
require'./lib/game'

class GameTest < MiniTest::Test

	def test_game_exists
		game = Game.new
		assert_instance_of Game, game
	end
  def test_answer
    game = Game.new(72)
    assert_equal 72,  game.answer
  end

  def test_guess_that_is_too_low
    game = Game.new(72)
    result = "You have made 1 guess(es)\nYour guess was 32, which is too low."

    assert_equal result, game.make_a_guess("32")
  end

  def test_guess_that_is_too_high
    game = Game.new(72)
    result = "You have made 1 guess(es)\nYour guess was 109, which is too high."

    assert_equal result, game.make_a_guess("109")
  end

  def test_correct_guess
    game = Game.new(72)
    result = "You have made 1 guess(es)\nYour guess was 72, which is correct!"

    assert_equal result, game.make_a_guess("72")
  end

  def test_guess_counter
  game = Game.new(72)

    game.make_a_guess("32")
    game.make_a_guess("109")
    game.make_a_guess("76")
    game.make_a_guess("2")

    assert_equal 4, game.guess_counter
  end
end