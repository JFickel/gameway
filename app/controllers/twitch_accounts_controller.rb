class TwitchAccountsController < ApplicationController
  def create
    twitch_account = TwitchAccount.new(twitch_account_params)
    twitch_account.user_id = current_user.id ## build through user
    respond_to do |format|
      if twitch_account.save
        format.json { render json: { message: 'Successfully added Twitch.tv Account' } }
      else
        format.json { render json: { message: 'Something went wrong adding your Twitch.tv Account' } }
      end
    end
  end

  def update
    twitch_account = current_user.twitch_account
    respond_to do |format|
      if twitch_account.update_attributes(twitch_account_params)
        format.json { render json: { message: 'Successfully updated Twitch.tv Account' } }
      else
        format.json { render json: { message: 'Something went wrong updating your Twitch.tv Account' } }
      end
    end
  end

  private

  def twitch_account_params
    params.require(:twitch_account).permit(:username)
  end
end
