require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:password)}
  it { should validate_presence_of(:username)}

  it { should have_many(:group_memberships)}
  it { should have_many(:groups).through(:group_memberships)}

  it { should have_many(:team_leaderships)}
  it { should have_many(:team_memberships)}
  it { should have_many(:teams).through(:team_memberships)}

  it { should have_many(:owned_tournaments)}
  it { should have_many(:tournament_memberships)}
  it { should have_many(:tournaments).through(:tournament_memberships)}
  it { should have_many(:user_showings)}
  it { should have_many(:matches).through(:user_showings)}
  it { should have_many(:moderator_roles)}
  it { should have_many(:moderated_tournaments).through(:moderator_roles)}


  it 'should have a valid factory' do
    expect(user).to be_valid
  end

  it 'should store a first name' do
    user.first_name = 'John'
    expect(user.first_name).to eq 'John'
  end

  it 'should store a last name' do
    user.last_name = 'Smith'
    expect(user.last_name).to eq 'Smith'
  end
end
