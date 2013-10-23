require 'spec_helper'

describe UserShowing do
  it {should belong_to(:user)}
  it {should belong_to(:match)}
  it {should validate_presence_of(:user_id)}
end
