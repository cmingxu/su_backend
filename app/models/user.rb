# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  include UUID
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :folders
  has_many :entities

  scope :normal_user, -> { where( "roles LIKE '%user%'" ) }
  scope :admin, -> { where( "roles LIKE '%admin%'" ) }

  before_create do |u|
    u.roles = 'user'
  end

  def user?
    self.roles =~ Regexp.new('user')
  end

  def admin?
    self.roles =~ Regexp.new('admin')
  end

  def make_admin!
    self.roles += ",admin"
    self.save!
  end

  def roles_in_words
    [self.user? ? "注册用户" : nil,  self.admin? ? "管理员" : nil].compact
  end
end
