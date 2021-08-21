class CriticsController < ApplicationController
  after_action :verify_policy_scoped, only: :index

  def index
    @critics = policy_scope(Critic)
  end

  def create
    # some code here
    skip_authorization
    # some code here
  end

  def update
    # some code here
    authorize @critic
  end

  def destroy
    # some code here
    authorize @critic
  end
end
