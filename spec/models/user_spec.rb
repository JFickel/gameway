require 'spec_helper'

describe User do
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
  let(:user) { User.new(@options) }
  let(:factory_user) { FactoryGirl.create(:user) }

  before do
    @options = {
      username: 'Johnny',
      first_name: 'John',
      last_name: 'Smith',
      email: 'johnsmith@gmail.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end


  describe '.initialize' do
    it 'should have a valid factory' do
      expect(factory_user).to be_valid
    end

    it 'should store a username' do
      expect(user.username).to eq 'Johnny'
    end

    it 'should store a first name' do
      expect(user.first_name).to eq 'John'
    end

    it 'should store a last name' do
      expect(user.last_name).to eq 'Smith'
    end

    it 'should store an email' do
      expect(user.email).to eq 'johnsmith@gmail.com'
    end

    it 'should store a password' do
      expect(user.password).to eq 'password'
    end

    it 'should store a password_confirmation' do
      expect(user.password_confirmation).to eq 'password'
    end
  end
end
