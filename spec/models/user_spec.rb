require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:password)}
  it { should have_many(:tournaments)}
  it { should have_many(:tournament_members)}
  it { should have_many(:owned_tournaments)}

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
