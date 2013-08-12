require 'spec_helper'

describe "user registration and sessions" do
  context "user signup" do
    it "allows me to manually sign up" do
      visit root_path
      fill_in 'Username', :with => 'example'
      fill_in 'Email', :with => 'example@example.com'
      fill_in 'Password', :with => 'password'
      fill_in 'Password Confirmation', :with => 'password'
      click 'Signup'
    end
    it "allows me to sign up with facebook"
    it "allows me to sign up with twitch"
  end

  context "user signin" do
    it "allows me to manually sign in"
    it "allows me to sign in with facebook"
    it "allows me to sign in with twitch"
  end

  context "user logout" do
    it "allows me to logout"
  end
  # fill_in 'Login', :with => 'user@example.com'
  # fill_in 'Password', :with => 'password'
end


