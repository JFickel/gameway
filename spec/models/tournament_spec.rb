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
  let (:tournament_with_users) { create(:tournament, :with_users, users_count: 14) }
  let (:tournament_with_teams) { create(:tournament, :with_teams, teams_count: 25) }
  let (:tournament_without_teams) { create(:tournament, :with_teams, teams_count: 0) }
  let (:tournament_without_users) { create(:tournament, :with_users, teams_count: 0) }
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

    it 'should generate a bracket with 5 arrays with 14 users' do
      expect(tournament_with_users.start.bracket.length).to eq 5
    end

    it 'should not generate a bracket with 0 users' do
      expect(tournament_without_users.bracket).to eq nil
    end

    it 'should generate a bracket with 6 arrays with 25 teams' do
      expect(tournament_with_teams.start.bracket.length).to eq 6
    end

    it 'should not generate a bracket with 0 users' do
      expect(tournament_without_teams.bracket).to eq nil
    end

    it 'should have 6 matches in the first round with 14 users' do
      expect(tournament_with_users.start.bracket.first.count {|e| e.class.try(:model_name).try(:singular) == 'match' }).to eq 6
    end

    it 'should initialize 7 matches total with 14 users' do
      expect(tournament_with_users.start.matches.count).to eq 7
    end

    it 'should have 9 matches in the first round with 25 teams' do
      expect(tournament_with_teams.start.bracket.first.count {|e| e.class == Match }).to eq 9
    end

    it 'should initialize 13 matches total with 25 teams' do
      expect(tournament_with_teams.start.matches.count).to eq 13
    end
  end
end
