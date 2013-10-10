class FindUserForOmniauth

  def self.call(omniauth_response)
    new(omniauth_response).find!
  end

  def initialize(omniauth_response)
    @omniauth_response = omniauth_response
  end

  def omniauth_info
    @omniauth_response.info
  end

  def omniauth_education_info
    @omniauth_education_info ||= @omniauth_response.try(:extra).try(:raw_info).try(:education)
  end

  def find!
    puts omniauth_info.inspect
    puts "HELLO"
    puts omniauth_info.email
    puts "HELLO"
    puts omniauth_education_info.inspect
    @user = User.find_by_email(omniauth_info.email) and return @user

    @user = User.new(
      :email      => omniauth_info.email,
      :first_name => omniauth_info.first_name,
      :username   => omniauth_info.nickname,
    )

    build_group_objects!

    return @user
  end

  def build_group_objects!
    return if omniauth_education_info.blank?

    omniauth_education_info.each do |education|
      group = Group.find_or_create_by(name: education.school.name, kind: education.type)
      @user.groups << group
    end
  end
end
