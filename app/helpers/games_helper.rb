module GamesHelper
  def country_user( country )
    country.game_player ? country.game_player.user.username : 'No Player'
  end
end
