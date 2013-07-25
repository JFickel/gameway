require 'spec_helper'

describe User do
  it { should validate_presence_of(:first_name)}
  it { should validate_presence_of(:last_name)}
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:password)}

  it "should have a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end
end
