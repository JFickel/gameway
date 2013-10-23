require 'spec_helper'

describe GroupMembership do
  it { should belong_to(:user)}
  it { should belong_to(:group)}
  it { should validate_uniqueness_of(:user_id).scoped_to(:group_id).with_message('can only sign up for a group once')}
end
