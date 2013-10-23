require 'spec_helper'

describe TournamentMembership do
  it { should belong_to(:user)}
  it { should belong_to(:tournament)}
  it { should validate_uniqueness_of(:user_id).scoped_to(:tournament_id).with_message('can only sign up once per tournament')}
end
