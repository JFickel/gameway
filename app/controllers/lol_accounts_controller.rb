class LolAccountsController < ApplicationController
  def create
    lol_account = LolAccount.new(lol_account_params)
    lol_account.user_id = current_user.id ## build through user
    if lol_account.save
      redirect_to request.referer
    else
      redirect_to request.referer, alert: user.errors.full_messages
    end
  end

  def update
    lol_account = current_user.lol_account
    respond_to do |format|
      if lol_account.update_attributes(lol_account_params)
        format.json { render json: { message: 'Successfully added League of Legends Account' } }
      else
        format.json { render json: { message: 'Something went wrong adding your League of Legends Account' } }
      end
    end
  end

  private

  def lol_account_params
    params.require(:lol_account).permit(:summoner_name)
  end
end
