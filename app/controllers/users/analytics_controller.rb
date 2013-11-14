class Users::AnalyticsController < Devise::SessionsController
  after_filter :add_analytics, only: [:create]
  def add_analytics
    Analytics.identify(
      user_id: current_user.id,
      traits: { email: current_user.email,
                first_name: current_user.first_name,
                last_name: current_user.last_name,
                username: current_user.username,
                tournament_memberships: current_user.tournament_memberships.count,
                events: current_user.events.count }
      )
  end
end
