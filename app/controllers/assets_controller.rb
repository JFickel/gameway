class AssetsController < ApplicationController
  def index
    inject_email_confirmed if flash[:email_confirmed]
  end

  def inject_email_confirmed
    gon.email_confirmed = true
  end
end
