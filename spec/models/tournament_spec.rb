require 'spec_helper'

describe Tournament do
  it { should belong_to(:owner) }
  it { should have_many(:tournament_memberships) }
  it { should have_many(:users).through(:tournament_memberships) }
  it { should have_many(:matches) }
  it { should have_many(:user_showings).through(:matches) }
  it { should have_many(:moderator_roles) }
  it { should have_many(:moderators).through(:moderator_roles) }
  let (:tournament) { Tournament.new(@options) }

  before do
    @options = { title: 'UIUC League of Legends Tournament',
                 game: 'League of Legends',
                 description: "Everyone is invited to this tournament hosted by the UIUC gaming club :D",
                 rules: 'None',
                 starts_at: DateTime.current + 30.seconds
               }
  end

  describe '.initialize' do
    it 'should store the title' do
      tournament.title.should == 'UIUC League of Legends Tournament'
    end

    it 'should store the game' do
      tournament.game.should == 'League of Legends'
    end

    it 'should store the description' do
      tournament.description.should == 'Everyone is invited to this tournament hosted by the UIUC gaming club :D'
    end

    it 'should store the rules' do
      tournament.rules.should == 'None'
    end
  end

  describe '.start' do
    it 'should return nil if bracket is not initialized' do
      tournament.bracket.should == nil
    end
  end
end
