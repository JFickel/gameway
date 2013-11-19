class Starcraft2AccountsController < ApplicationController
  def create
    sc2_account = Starcraft2Account.new(starcraft2_account_params)
    sc2_account.user_id = current_user.id ## build through user
    if sc2_account.save
      # respond_to do |format|
      redirect_to request.referer
        # format.js { render json: { status: 'success' }}
      # end
    else
      redirect_to request.referer, alert: user.errors.full_messages
    end
  end

  def update
    account = current_user.starcraft2_account
    respond_to do |format|
      if account.update_attributes(starcraft2_account_params)
        format.json { render json: { message: 'Successfully added Starcraft 2 Account' } }
      else
        format.json { render json: { message: 'Something went wrong adding your Starcraft 2 Account' } }
      end
    end
  end

  private

  def starcraft2_account_params
    params.require(:starcraft2_account).permit(:url)
  end
end
