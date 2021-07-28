# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  email              :string
#  name               :string
#  password_digest    :string
#  temporary_password :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class User < ApplicationRecord
  has_secure_password
  validates :name, :email, presence: true

  scope :all_except, ->(user_id) { where.not(id: user_id) }
end
