# == Schema Information
#
# Table name: entities
#
#  id         :integer          not null, primary key
#  folder_id  :integer
#  name       :string(255)
#  skp_file   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class EntityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
