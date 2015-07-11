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

class Entity < ActiveRecord::Base
  include UUID
  belongs_to :user
  belongs_to :folder

  validates :folder_id, :skp_file, :name, :user_id, presence: true
  validates :name, uniqueness: { scope: :user_id }
  validates :name, uniqueness: { scope: :folder_id }

  scope :site_level, -> { where(is_system: false) }

  mount_uploader :skp_file, SkpFileUploader
  mount_uploader :icon, EntityIconUploader

end
