require 'spec_helper'

describe Tournament do
  it { should belong_to(:owner) }
  it { should have_many(:tournament_members) }
  it { should have_many(:users) }
end
