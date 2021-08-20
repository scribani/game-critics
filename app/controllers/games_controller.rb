class GamesController < ApplicationController
  #get /games
  def index
    @games = Game.all
  end

  #get /games/new
  def new
    @game = Game.new
    @main_games = Game.main_game
  end

end
