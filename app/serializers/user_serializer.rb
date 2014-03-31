class UserSerializer < ApplicationSerializer
  attributes :id, :email

  has_one :lol_account
end
