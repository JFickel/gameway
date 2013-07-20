class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  config.to_prepare do
    Devise::SessionsController.skip_before_filter :authenticate_user, only: [:new]
    Devise::RegistrationsController.skip_before_filter :authenticate_user, only: [:new]
  end
end
