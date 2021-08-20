class GamesController < ApplicationController
  #get /games
  def index
    @games = Game.all
  end
end
