require 'spec_helper'

describe Affiliation do
  it { should belong_to(:affiliate_team)}
  it { should belong_to(:affiliated_tournament)}
  it { should belong_to(:affiliated_team)}
  it { should belong_to(:affiliated_group)}
end
