# == Schema Information
#
# Table name: artists
#
#  id              :bigint           not null, primary key
#  about           :text
#  email           :string
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Artist < ApplicationRecord
  has_secure_password
  validates :name, :about, presence: true
  has_many :posts
end
