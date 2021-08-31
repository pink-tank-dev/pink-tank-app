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
end
