class CriticsController < ApplicationController
  after_action :verify_policy_scoped, only: %i[index create]

  # GET /:criticable/:criticable_id/critics
  def index
    skip_authorization

    @criticable_type = params[:criticable]

    @criticable = Game.find(params[:criticable_id]) if @criticable_type == "games"
    @criticable = Company.find(params[:criticable_id]) if @criticable_type == "companies"

    @critics = policy_scope(Critic)
  end

  # POST /:criticable/:criticable_id/critics
  def create
    skip_authorization

    @criticable_type = params[:criticable]

    @criticable = Game.find(params[:criticable_id]) if @criticable_type == "games"
    @criticable = Company.find(params[:criticable_id]) if @criticable_type == "companies"

    critic = @criticable.critics.new(critic_params)
    critic.user = current_user
    critic.save

    @critics = policy_scope(Critic)

    redirect_to critics_path(criticable: @criticable_type, criticable_id: @criticable.id)
  end

  def update
    # some code here
    authorize @critic
  end

  def destroy
    # some code here
    authorize @critic
  end

  private

  # Only allow a list of trusted parameters through.
  def critic_params
    params.permit(:title, :body)
  end
end
