# == Schema Information
#
# Table name: materials
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  vendor_id  :integer
#  icon       :string(255)
#  price      :decimal(10, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Material, type: :model do
  it { should belong_to(:vendor) }
  describe "UUID" do
    it 'should include UUID module' do
      expect(Material.ancestors).to include(UUID)
      expect(Material.new).to have_db_column(:uuid)
    end
  end
  describe "validations" do
    it 'should validate presence of name, icon, vendor_id, price' do
      expect(Material.new).to validate_presence_of(:name)
      expect(Material.new).to validate_presence_of(:icon)
      expect(Material.new).to validate_presence_of(:vendor_id)
      expect(Material.new).to validate_presence_of(:price)
    end

    it 'should validate numericality of price' do
      expect(Material.new).to validate_numericality_of(:price)
    end

    it 'should validate uniqueness of name within scope of vendor id' do
      expect(Material.new).to validate_uniqueness_of(:name).scoped_to(:vendor_id)
    end
  end
end
