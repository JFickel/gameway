class TwitchAccountsController < ApplicationController
  def create
    twitch_account = TwitchAccount.new(twitch_account_params)
    twitch_account.user_id = current_user.id ## build through user
    if twitch_account.save
      redirect_to request.referer
    else
      flash[:alert] = user.errors.full_messages ## change alerts
      redirect_to request.referer
    end
  end

  def update
    twitch_account = current_user.twitch_account
    if twitch_account.update_attributes(twitch_account_params)
      redirect_to request.referer
    else
      flash[:alert] = user.errors.full_messages
      redirect_to request.referer
    end
  end

  private

  def twitch_account_params
    params.require(:twitch_account).permit(:username)
  end
end
