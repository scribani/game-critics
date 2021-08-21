module GamesConcern
  extend ActiveSupport::Concern
  # -----------------   GENRE - ADD AND REMOVE FOR COLECCTION-SELECT
  # POST /games/:id/add_genre
  def add_genre
    game = Game.find(params[:id])
    authorize game

    genre = Genre.find(params[:id_genre])
    game.genres << genre

    redirect_to game
  end

  # DELETE /games/:id/remove_genre
  def remove_genre
    game = Game.find(params[:id])
    authorize game

    genre = Genre.find(params[:genre_id])
    game.genres.delete(genre)

    redirect_to game
  end

  # -----------------   PLATFORM - ADD AND REMOVE FOR COLECCTION-SELECT
  # POST /games/:id/add_genre
  def add_platform
    game = Game.find(params[:id])
    authorize game

    platform = Platform.find(params[:id_platform])
    game.platforms << platform

    redirect_to game
  end

  # DELETE /games/:id/remove_platform
  def remove_platform
    game = Game.find(params[:id])
    authorize game

    platform = Platform.find(params[:platform_id])
    game.platforms.delete(platform)

    redirect_to game
  end

  # -----------------   DEVELOPER - ADD AND REMOVE FOR COLECCTION-SELECT
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

  # DELETE /games/:id/publisher
  def remove_developer
    @game = Game.find(params[:id])
    authorize @game

    company = Company.find(params[:developer_id])
    comp_dev = @game.involved_companies.where(company_id: company).first
    @game.involved_companies.delete(comp_dev)

    redirect_to @game
  end

  # -----------------   PUBLISHER - ADD AND REMOVE FOR COLECCTION-SELECT
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
end
