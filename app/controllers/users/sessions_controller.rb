class Users::SessionsController < Devise::SessionsController
  def create
    super do |resource|
      output = JSON.parse(UserSerializer.new(resource).to_json)
      output[:authenticity_token] = session[:_csrf_token]
      render json: { user: UserSerializer.new(resource) }
      return
    end
  end
end
