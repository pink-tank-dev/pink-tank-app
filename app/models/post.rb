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

  def corrected_html
    html = body.to_s
    doc = Nokogiri::HTML(html)
    attachments = doc.css("action-text-attachment")
    return doc.to_s unless attachments.present?
    correct_media_src_url(attachments, "img")
    correct_media_src_url(attachments, "video")
    correct_media_src_url(attachments, "audio")
    correct_media_src_url(attachments, "embed")
    doc.to_s
  end

  def correct_media_src_url(attachments, media_type)
    attachments.each do |node|
      url = node["url"]
      media = node.css(media_type).first
      next unless media.present?
      media["src"] = url
    end
  end
end
