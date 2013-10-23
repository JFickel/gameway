require 'spec_helper'

describe Group do
  it { should have_many(:group_memberships)}
  it { should have_many(:users)}
  it { should validate_presence_of(:name)}
  it { should validate_uniqueness_of(:name)}
end
