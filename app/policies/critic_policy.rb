class CriticPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user).or(scope.where(approved: true))
      end
    end

    def destroy?
      record.user == current_user
    end
  end
end
