class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      output = JSON.parse(UserSerializer.new(resource).to_json)
      output[:authenticity_token] = form_authenticity_token
      render json: output
      return
    end
  end
end
