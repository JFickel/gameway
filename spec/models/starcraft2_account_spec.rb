require 'spec_helper'

describe Starcraft2Account do
  it { should belong_to(:user)}
end
