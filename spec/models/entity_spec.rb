# == Schema Information
#
# Table name: entities
#
#  id          :integer          not null, primary key
#  folder_id   :integer
#  name        :string(255)
#  skp_file    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  description :text(65535)
#  icon        :string(255)
#

require 'rails_helper'

RSpec.describe Entity, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:folder) }
end
