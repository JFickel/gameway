class Users::SessionsController < Devise::SessionsController
  def create
    super do |resource|
      output = JSON.parse(UserSerializer.new(resource).to_json)
      output[:authenticity_token] = form_authenticity_token
      render json: output
      return
    end
  end

  def destroy
    super do |resource|
      render json: { authenticity_token: form_authenticity_token }
      return
    end
  end
end
