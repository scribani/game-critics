class GamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def add_genre?
    user.admin?
  end

  def remove_genre?
    user.admin?
  end

  def add_platform?
    user.admin?
  end

  def remove_platform?
    user.admin?
  end

  def add_developer?
    user.admin?
  end

  def remove_developer?
    user.admin?
  end

  def add_publisher?
    user.admin?
  end

  def remove_publisher?
    user.admin?
  end
end
