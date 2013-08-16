require 'spec_helper'

describe Tournament do
  it { should belong_to(:user) }
end
