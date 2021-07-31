# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  published_at :datetime
#  status       :integer          default("draft"), not null
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  artist_id    :bigint
#
# Indexes
#
#  index_posts_on_artist_id  (artist_id)
#
class Post < ApplicationRecord
  enum status: { draft: 0, published: 1 }
  validates :title, presence: true
  has_rich_text :body
  belongs_to :artist

  def html
    body.body.to_html
  end

  def html_with_layout
    body.body.to_rendered_html_with_layout
  end
end
