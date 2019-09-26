require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def setup
    @game = Game.new({
      user: users(:user_one),
      name: 'Test Game',
      game_players: game_players
    })
  end

  test "creating a game" do
    assert_nil @game.id
    assert_equal 7, @game.game_players.length
    @game.save!
    assert_not_nil @game.id
  end

  test "starting a game" do
    @game.save!
    @game.start

    assert_not_nil @game.started_at
    assert_equal 7, @game.game_countries.length
  end
end
