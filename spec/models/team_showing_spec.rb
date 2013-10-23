require 'spec_helper'

describe TeamShowing do
  it { should belong_to(:team)}
  it { should belong_to(:match)}
end
