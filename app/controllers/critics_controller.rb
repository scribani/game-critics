class CriticsController < ApplicationController
  after_action :verify_policy_scoped, only: %i[index create]
  after_action :skip_authorization, only: %i[index create]

  # GET /:criticable/:criticable_id/critics
  def index
    data = criticable_data

    @criticable_type = data[:criticable_type]
    @criticable = data[:criticable]
    @critics = policy_scope(@criticable.critics)
  end

  # POST /:criticable/:criticable_id/critics
  def create
    data = criticable_data

    @criticable_type = data[:criticable_type]
    @criticable = data[:criticable]
    @critics = policy_scope(@criticable.critics)

    critic = @criticable.critics.new(critic_params)
    critic.user = current_user
    critic.save

    redirect_to critics_path(criticable: @criticable_type, criticable_id: @criticable.id)
  end

  # PATCH /:criticable/:criticable_id/critics/:critic_id
  def update
    data = criticable_data

    @criticable_type = data[:criticable_type]
    @criticable = data[:criticable]
    @critics = policy_scope(@criticable.critics)

    critic = @criticable.critics.find(params[:critic_id])
    authorize critic

    critic.approved = true
    critic.save

    redirect_to critics_path(criticable: @criticable_type, criticable_id: @criticable.id)
  end

  # DELETE /:criticable/:criticable_id/critics/:critic_id
  def destroy
    data = criticable_data

    @criticable_type = data[:criticable_type]
    @criticable = data[:criticable]
    @critics = policy_scope(@criticable.critics)

    critic = @criticable.critics.find(params[:critic_id])
    authorize critic

    critic.destroy

    redirect_to critics_path(criticable: @criticable_type, criticable_id: @criticable.id)
  end

  private

  # Only allow a list of trusted parameters through.
  def critic_params
    params.permit(:title, :body)
  end

  def criticable_data
    criticable_type = params[:criticable]
    criticable = Game.find(params[:criticable_id]) if criticable_type == "games"
    criticable = Company.find(params[:criticable_id]) if criticable_type == "companies"

    {
      criticable_type: criticable_type,
      criticable: criticable
    }
  end
end
