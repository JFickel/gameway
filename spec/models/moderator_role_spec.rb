require 'spec_helper'

describe ModeratorRole do
  it { should belong_to(:user)}
  it { should belong_to(:tournament)}
end
