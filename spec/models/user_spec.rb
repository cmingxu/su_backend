require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:folders) }
  it { should have_many(:entities) }
end
