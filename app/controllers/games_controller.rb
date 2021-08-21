class GamesController < ApplicationController
  def index
    # some code here
    authorize @games
  end

  def show
    # some code here
    authorize @game
  end

  def new
    # some code here
    authorize @game
  end

  def create
    # some code here
    authorize @game
  end

  def edit
    # some code here
    authorize @game
  end

  def update
    # some code here
    authorize @game
  end

  def destroy
    # some code here
    authorize @game
  end
end
