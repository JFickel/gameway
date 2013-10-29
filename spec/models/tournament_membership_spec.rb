require 'spec_helper'

describe TournamentMembership do
  it { should belong_to(:user)}
  it { should belong_to(:tournament)}
end
