class AssetsController < ApplicationController
  def index
    gon.email_confirmed = flash[:email_confirmed]
    gon.first_twitch_auth = flash[:first_twitch_auth]
  end
end
