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

class Material < ActiveRecord::Base
  include UUID
  validates :name, :icon, :vendor_id, :price, presence: true
  validates :price, numericality: true
  validates :name, uniqueness: { scope: :vendor_id }

  belongs_to :vendor
end
