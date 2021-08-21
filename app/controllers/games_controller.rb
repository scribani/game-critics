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
  # GET /games/:id
  def show
    @game = Game.find(params[:id])
    @genres = @game.genres.map {|genre| genre.name}
    @platforms = @game.platforms.map {|platform| platform.name}
    @developers = @game.involved_companies.where(developer: true).map {|ic| ic.company}
    @publishers = @game.involved_companies.where(publisher: true).map {|ic| ic.company}
    # @critics = @game.critics

    # @game = Game.all
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
    redirect_to game_path
  end

  # POST /games/:id/add_genre
  def add_genre
    game = Game.find(params[:id])
    genre = Genre.find(params[:genre_id])

    game.genres << genre
    render json: nil, status: :ok
  end

  def game_params
    params.require(:game).permit(:name, :summary, :release_date, :category, :rating, :parent_id, :cover)
  end

end
