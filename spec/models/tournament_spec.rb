require 'spec_helper'

describe Tournament do
  it { should belong_to(:owner) }
  it { should have_many(:tournament_memberships) }
  it { should have_many(:users).through(:tournament_memberships) }
  it { should have_many(:matches) }
  it { should have_many(:user_showings).through(:matches) }
  it { should have_many(:moderator_roles) }
  it { should have_many(:moderators).through(:moderator_roles) }
end
