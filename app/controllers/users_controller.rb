class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    if params[:file_data]
      current_user.avatar = uploaded_avatar_file
    else
      current_user.assign_attributes(user_params)
    end

    if current_user.save
      render json: current_user
    else
      render json: { errors: current_user.errors.messages }, status: 422
    end
  end

  private

    def uploaded_avatar_file
      clean_base64 = params[:file_data].gsub(/.*base64,/, '')
      decoded_base64 = Base64.decode64(clean_base64)

      file_path = "tmp/#{current_user.id}-avatar#{params[:file_extension]}"
      File.open(file_path, 'wb') { |file| file.write(decoded_base64) }

      File.new(file_path)
    end

    def user_params
      params.require(:user).permit(:name)
    end
end
