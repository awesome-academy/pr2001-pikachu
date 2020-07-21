# frozen_string_literal: true

# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  tour_id    :integer          not null
#  user_id    :integer          not null
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Review < ApplicationRecord
  has_many :likes
  has_many :comments
  belongs_to :user
  belongs_to :tour
  mount_uploader :picture, ImageUploader
  validates :user_id, presence: true
  validates  :tour_id, presence: true
  validates :content, presence: true, length: { maximum: 500 }
end
