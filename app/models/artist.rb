# == Schema Information
#
# Table name: artists
#
#  id         :bigint           not null, primary key
#  about      :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artist < ApplicationRecord
  validates :name, :about, presence: true
  has_many :posts
end
