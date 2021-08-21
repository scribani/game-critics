class GamesController < ApplicationController
  include GamesConcern
  # get /games
  def index
    @games = Game.order(:name).page(params[:page]).per(5)
    authorize @games
  end

  # get /games/new
  def new
    @game = Game.new
    authorize @game

    @main_games = Game.main_game
  end

  # GET /games/:id
  def show
    @game = Game.find(params[:id])
    authorize @game

    @genres = @game.genres
    @platforms = @game.platforms

    @critics = @game.critics

    show_pub_dev
  end

  def show_pub_dev
    @developers_total = InvolvedCompany.where(developer: true).map(&:company).uniq
    @developers = @game.involved_companies.where(developer: true).map(&:company)
    @developers_list = (@developers_total - @developers)

    @publishers_total = InvolvedCompany.where(publisher: true).map(&:company).uniq
    @publishers = @game.involved_companies.where(publisher: true).map(&:company)
    @publishers_list = (@publishers_total - @publishers)
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    authorize @game

    if @game.save
      redirect_to @game
    else
      render "new"
    end
  end

  # GET /games/:id/edit
  def edit
    @game = Game.find(params[:id])
    authorize @game
  end

  # PATCH/PUT /games/:id
  def update
    @game = Game.find(params[:id])
    authorize @game

    if @game.update(game_params)
      redirect_to @game
    else
      render :edit
    end
  end

  # DELETE /games/:id
  def destroy
    @game = Game.find(params[:id])
    authorize @game

    @game.destroy
    redirect_to root_path
  end

  def game_params
    params.require(:game).permit(:name, :summary, :release_date, :category, :rating, :parent_id,
                                 :cover)
  end
end
