class Starcraft2AccountsController < ApplicationController
  def create
    sc2_account = Starcraft2Account.new(starcraft2_account_params)
    sc2_account.user_id = current_user.id ## build through user
    if sc2_account.save
      redirect_to request.referer
    else
      redirect_to request.referer, alert: user.errors.full_messages
    end
  end

  def update
    sc2_account = current_user.starcraft2_account
    if sc2_account.update_attributes(starcraft2_account_params)
      redirect_to request.referer
    else
      redirect_to request.referer, alert: user.errors.full_messages
    end
  end

  private

  def starcraft2_account_params
    params.require(:starcraft2_account).permit(:url)
  end
end
