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
  let (:team) { FactoryGirl.create(:team) }

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
      expect(tournament.title).to eq 'UIUC League of Legends Tournament'
    end

    it 'should store the game' do
      expect(tournament.game).to eq 'League of Legends'
    end

    it 'should store the description' do
      expect(tournament.description).to eq 'Everyone is invited to this tournament hosted by the UIUC gaming club :D'
    end

    it 'should store the rules' do
      expect(tournament.rules).to eq 'None'
    end
  end

  describe '.start' do
    it 'should have nil value for bracket if not started yet'  do
      expect(tournament.bracket).to eq nil
    end

    # it 'should generate a bracket with 5 arrays for 14 users' do
    #   expect(create(:tournament, :with_teams, teams_count: 14).start.bracket.length).to eq 5
    # end
  end
end
