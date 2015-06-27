# == Schema Information
#
# Table name: folders
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  entity_count :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Folder < ActiveRecord::Base
  belongs_to :user
  has_many :entities
end
