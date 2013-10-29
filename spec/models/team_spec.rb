require 'spec_helper'

describe Team do
  it { should have_many(:team_memberships)}
  it { should have_many(:users).through(:team_memberships)}
  it { should belong_to(:leader)} # class_name(:user)?

  it { should validate_presence_of(:name)}
  it { should ensure_length_of(:name).is_at_least(3).is_at_most(24)}
  it { should validate_uniqueness_of(:name).case_insensitive }
  let(:team) { FactoryGirl.create(:team)}

  describe '.initialize' do
    it 'should have a valid factory' do
      expect(team).to be_valid
    end

    it 'should have a factory with a leader' do
      expect(team.leader).to be_an_instance_of User
    end
  end
end
