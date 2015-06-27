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

require 'test_helper'

class FolderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
