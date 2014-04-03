class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    uploaded_avatar_file = decode_file_data if params[:file_data]
    current_user.avatar = uploaded_avatar_file
    if current_user.save
      render json: { avatar_url: current_user.avatar.url }
    else
      render json: { errors: current_user.errors.messages }
    end
  end

  private

    def decode_file_data
      clean_base64 = params[:file_data].gsub(/.*base64,/, '')
      decoded_base64 = Base64.decode64(clean_base64)

      file_path = "tmp/#{current_user.id}-avatar#{params[:file_extension]}"
      File.open(file_path, 'wb') { |file| file.write(decoded_base64) }

      File.new(file_path)
    end
end
