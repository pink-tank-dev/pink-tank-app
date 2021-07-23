# == Schema Information
#
# Table name: artists
#
#  id              :bigint           not null, primary key
#  about           :text
#  email           :string
#  instagram       :string
#  name            :string
#  password_digest :string
#  statement       :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Artist < ApplicationRecord
  has_secure_password
  validates :name, :email, :about, presence: true
  has_many :posts
end
