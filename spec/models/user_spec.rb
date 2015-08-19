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
#  uuid                   :string(255)
#  roles                  :string(255)
#  visible                :boolean          default(TRUE)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:folders) }
  it { should have_many(:entities) }

  it 'should have roles' do
    expect(User.new).to have_db_column(:roles)
    expect(User.new).to serialize(:roles)
    expect(create(:user).roles).to include("user")
    expect(create(:user)).not_to be_admin
    expect(create(:user)).to be_user
  end

  it 'should have db column visible' do
    expect(User.new).to have_db_column(:visible)
    expect(User.new.visible).to eql(true)
  end

end
