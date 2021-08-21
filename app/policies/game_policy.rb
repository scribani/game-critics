class GamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def add_platform?
    false
  end
  def add_genre?
    false
  end
end
