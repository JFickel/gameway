require 'spec_helper'

describe Team do
  it { should have_many(:team_memberships)}
  it { should have_many(:users).through(:team_memberships)}
  it { should belong_to(:leader)}

  it { should validate_presence_of(:name)}
  it { should ensure_length_of(:name).is_at_least(3).is_at_most(24)}
  it { should validate_uniqueness_of(:name).case_insensitive }
end
