class CurrentUserController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:fetch]
  def fetch
    render json: current_user, serializer: UserSerializer
  end
end
