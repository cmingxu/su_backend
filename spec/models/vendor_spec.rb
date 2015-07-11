# == Schema Information
#
# Table name: vendors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  tel        :string(255)
#  address    :string(255)
#  short_desc :text(65535)
#  desc       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Vendor, type: :model do
  it { should have_many(:materials) }

  it 'should include UUID' do
    expect(Vendor.ancestors).to include(UUID)
    expect(Vendor.new).to have_db_column(:uuid)
  end

  it 'should validates' do
    expect(Vendor.new).to validate_presence_of(:name)
    expect(Vendor.new).to validate_presence_of(:address)
    expect(Vendor.new).to validate_presence_of(:short_desc)

    expect(Vendor.new).to validate_uniqueness_of(:name)
  end
end
