# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  status     :integer          default("draft"), not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :bigint
#
# Indexes
#
#  index_posts_on_artist_id  (artist_id)
#
class Post < ApplicationRecord
  enum status: { draft: 0, posted: 1 }
  validates :title, presence: true
  belongs_to :artist
end
