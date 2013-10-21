require 'spec_helper'

describe Tournament do
  it { should belong_to(:owner) }
  it { should have_many(:tournament_memberships) }
  it { should have_many(:users) }
  it { should have_many(:matches) }
  it { should have_many(:moderator_roles) }
  it { should have_many(:moderators) }
end
