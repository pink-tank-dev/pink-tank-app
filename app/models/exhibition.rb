# == Schema Information
#
# Table name: exhibitions
#
#  id          :bigint           not null, primary key
#  description :text
#  end_at      :datetime
#  start_at    :datetime
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Exhibition < ApplicationRecord
  has_many :series, dependent: :destroy
  has_many :artworks, through: :series
  has_many :artists, through: :series

  validates :title, :description, presence: true
  validates :start_at, :end_at, presence: true
  validate :non_overlapping_dates, if: -> { start_at.present? && end_at.present? }

  scope :current , -> do
    where("start_at <= ? AND end_at >= ?", DateTime.current, DateTime.current)
  end

  def non_overlapping_dates
    if start_at.to_date > end_at.to_date
      errors.add(:start_at, "overlaps end date")
      errors.add(:end_at, "overlaps start date")
    end
  end
end
