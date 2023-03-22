class Team < ApplicationRecord
    scope :find_team_for_assignment_and_user, lambda { |assignment_id, user_id|
        joins(:teams_users).where('teams.parent_id = ? AND teams_users.user_id = ?', assignment_id, user_id)
      }
end