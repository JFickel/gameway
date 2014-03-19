class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    super do |resource|
      flash[:email_confirmed] = true
      redirect_to root_path
      return
    end
  end
end
