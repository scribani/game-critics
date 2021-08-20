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

  # POST /games
  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game
    else
      render "new"
    end
  end

  # GET /games/:id/edit
  def edit
    @game = Game.find(params[:id])
  end
  
  # PATCH/PUT /games/:id
  def update
    @game = Game.find(params[:id])

    if @game.update(game_params)
      redirect_to @game
    else
      render :edit
    end
  end


  # DELETE /games/:id
  def destroy
    game = Game.find(params[:id])
    game.destroy
    redirect_to games_path
  end

  def game_params
    params.require(:game).permit(:name, :summary, :release_date, :category, :rating, :parent_id)
  end

end
