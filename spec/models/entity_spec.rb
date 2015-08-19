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
#  uuid        :string(255)
#  is_system   :boolean          default(FALSE)
#  visible     :boolean          default(TRUE)
#

require 'rails_helper'

RSpec.describe Entity, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:folder) }

  describe '#site_level sope' do
    it 'scope should include' do
      @entity = create :entity
      @entity.is_system = true

      expect(Entity.site_level).to include(@entity)
    end
  end

  describe "validations" do
    it '' do
      expect(Entity.new).to validate_presence_of(:folder_id)
      expect(Entity.new).to validate_presence_of(:skp_file)
      expect(Entity.new).to validate_presence_of(:name)
    end
  end
end
