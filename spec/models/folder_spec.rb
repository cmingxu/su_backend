# == Schema Information
#
# Table name: folders
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  entity_count :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#

require 'rails_helper'

RSpec.describe Folder, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:entities) }
end
