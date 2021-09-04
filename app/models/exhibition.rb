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
  validates :title, :description, presence: true
  validates :start_at, :end_at, presence: true
  validate :non_overlapping_dates, if: -> { start_at.present? && end_at.present? }

  def non_overlapping_dates
    if start_at.to_date > end_at.to_date
      errors.add(:start_at, "overlaps end date")
      errors.add(:end_at, "overlaps start date")
    end
  end
end
