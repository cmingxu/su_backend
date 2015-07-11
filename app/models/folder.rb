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

class Folder < ActiveRecord::Base
  include UUID

  belongs_to :user
  has_many :entities
end
