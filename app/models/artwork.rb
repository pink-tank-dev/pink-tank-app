# == Schema Information
#
# Table name: artworks
#
#  id           :bigint           not null, primary key
#  description  :text
#  measurements :string
#  medium       :string
#  notes        :text
#  position     :integer
#  price_cents  :integer          default(0), not null
#  status       :integer
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  artist_id    :bigint
#
# Indexes
#
#  index_artworks_on_artist_id  (artist_id)
#
class Artwork < ApplicationRecord
  include Rails.application.routes.url_helpers

  acts_as_list

  belongs_to :artist

  has_one_attached :file

  validates :title, :description, presence: true
  validates :medium, :measurements, :status, presence: true

  enum status: %i[available sold]

  monetize :price_cents

  scope :by_artist, -> (id) { where(artist_id: id) }

  def file_html
    return unless file.present?
    Nokogiri::HTML::Builder.new do |doc|
      doc.html {
        if file.video?
          doc.video src: rails_blob_url(file),
                    preload: "auto",
                    controls: true,
                    width: "100%",
                    height: "100%"
        elsif file.audio?
          doc.audio(controls: true, autoplay: true) {
            doc.source src: rails_blob_url(file)
          }
        elsif file.content_type == 'application/pdf'
          doc.embed src: rails_blob_url(file),
                    width: "100%",
                    height: "500",
                    type: "application/pdf"
        elsif file.representable?
          doc.img src: rails_blob_url(file)
        end
      }
    end.to_html
  end
end
