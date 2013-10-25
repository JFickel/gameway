class TimeZonesController < ApplicationController
  skip_before_filter :authenticate_user!
  def create
    if session[:time_zone].present?
      render json: { timezone: true }
    else
      session[:time_zone] = params[:time_zone]
      Time.zone = params[:time_zone]
      render json: { timezone: false }
    end
  end
end
