require 'spec_helper'

describe Match do
  it { should belong_to(:tournament)}
  it { should have_many(:user_showings)}
  it { should have_many(:users).through(:user_showings)}
  it { should have_many(:team_showings)}
  it { should have_many(:teams).through(:team_showings)}
end
