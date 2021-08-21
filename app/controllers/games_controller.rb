class GamesController < ApplicationController
  # get /games
  def index
    @games = Game.all
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

    @genre = Genre.new
    @platform = Platform.new

    @genres = @game.genres.map(&:name)
    @platforms = @game.platforms.map(&:name)


    @developers_total = InvolvedCompany.where(developer: true).map(&:company).uniq
    @developers = @game.involved_companies.where(developer: true).map(&:company)
    @developers_list = (@developers_total - @developers)

    @publishers_total = InvolvedCompany.where(publisher: true).map(&:company).uniq
    @publishers = @game.involved_companies.where(publisher: true).map(&:company)
    @publishers_list = (@publishers_total - @publishers)


    # @critics = @game.critics

    # @game = Game.all
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

  # POST /games/:id/add_genre
  def add_genre
    game = Game.find(params[:id])
    authorize game

    genre = Genre.find(params[:genre][:id])
    game.genres << genre

    redirect_to game
  end

  # POST /games/:id/add_genre
  def add_platform
    game = Game.find(params[:id])
    authorize game

    platform = Platform.find(params[:platform][:id])
    game.platforms << platform

    redirect_to game
  end

  # POST /games/:id/developers
  def add_developer
    @game = Game.find(params[:id])
    authorize @game

    company = Company.find(params[:develop_id])
    @game.companies << company
    comp_dev = @game.involved_companies.where(company_id: company).first
    comp_dev.developer = true
    comp_dev.save

    redirect_to @game
  end

  # POST /games/:id/publishers
  def add_publisher
    @game = Game.find(params[:id])
    authorize @game

    company = Company.find(params[:publisher_id])
    @game.companies << company
    comp_pub = @game.involved_companies.where(company_id: company).first
    comp_pub.publisher = true
    comp_pub.save

    redirect_to @game
  end

  # -----------DELETE
  # DELETE /games/:id/publisher
  def remove_publisher
    @game = Game.find(params[:id])
    authorize @game

    company = Company.find(params[:publisher_id])
    comp_pub = @game.involved_companies.where(company_id: company).first
    @game.involved_companies.delete(comp_pub)

    redirect_to @game
  end

  def game_params
    params.require(:game).permit(:name, :summary, :release_date, :category, :rating, :parent_id, :cover)
  end

end
