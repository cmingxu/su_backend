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

class Entity < ActiveRecord::Base
  belongs_to :user
  belongs_to :folder

  mount_uploader :skp_file, SkpFileUploader
end
