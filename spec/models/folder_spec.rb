require 'rails_helper'

RSpec.describe Folder, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:entities) }
end
