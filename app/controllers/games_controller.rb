class GamesController < ApplicationController
  # get /games
  def index
    @games = Game.all

    authorize @games
  end

  # get /games/new
  def new
    @game = Game.new
    @main_games = Game.main_game

    authorize @games
  end

  # GET /games/:id
  def show
    @game = Game.find(params[:id])

    @genre = Genre.new
    @platform = Platform.new
    @developer = InvoldedCompany.new

    @genres = @game.genres.map(&:name)
    @platforms = @game.platforms.map(&:name)
    @developers = @game.involved_companies.where(developer: true).map(&:company)
    @publishers = @game.involved_companies.where(publisher: true).map(&:company)
    # @critics = @game.critics

    # @game = Game.all
    authorize @games
  end

  # POST /games
  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game
    else
      render "new"
    end

    authorize @games
  end

  # GET /games/:id/edit
  def edit
    @game = Game.find(params[:id])

    authorize @games
  end

  # PATCH/PUT /games/:id
  def update
    @game = Game.find(params[:id])

    if @game.update(game_params)
      redirect_to @game
    else
      render :edit
    end

    authorize @games
  end

  # DELETE /games/:id
  def destroy
    game = Game.find(params[:id])
    game.destroy
    redirect_to game_path

    authorize @games
  end

  # POST /games/:id/add_genre
  def add_genre
    game = Game.find(params[:id])
    genre = Genre.find(params[:genre][:id])

    game.genres << genre

    authorize @games
  end

  # POST /games/:id/add_genre
  def add_platform
    game = Game.find(params[:id])
    platform = Platform.find(params[:platform][:id])

    game.platforms << platform

    authorize @games
  end

  def game_params
    params.require(:game).permit(:name, :summary, :release_date, :category, :rating, :parent_id, :cover)

    authorize @games
  end
end
