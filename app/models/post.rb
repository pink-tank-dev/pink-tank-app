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
    correct_img_src_url(attachments)
    correct_video_src_url(attachments)
    doc.to_s
  end

  def correct_img_src_url(attachments)
    attachments.each do |node|
      url = node["url"]
      img = node.css("img").first
      next unless img.present?
      img["src"] = url
    end
  end

  def correct_video_src_url(attachments)
    attachments.each do |node|
      url = node["url"]
      video = node.css("video").first
      next unless video.present?
      video["src"] = url
    end
  end
end
