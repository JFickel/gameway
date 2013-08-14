require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:password)}

  it "should have a valid factory" do
    expect(user).to be_valid
  end

  it "is invalid without a firstname" do
  end

  it "should store a first name" do
  end


  it 'should store a last name' do
  end
end
