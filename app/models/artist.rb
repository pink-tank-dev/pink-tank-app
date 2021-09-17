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
#  status          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Artist < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  has_one :series
  has_many :posts
  has_many :social_media
  accepts_nested_attributes_for :social_media, reject_if: :all_blank, allow_destroy: true

  validates :name, :email, :about, :statement, presence: true
  validates :status, presence: true

  enum status: %i[active inactive]
end
