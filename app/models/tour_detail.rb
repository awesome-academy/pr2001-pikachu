# frozen_string_literal: true

# == Schema Information
#
# Table name: tour_details
#
#  id             :integer          not null, primary key
#  tour_id        :integer          not null
#  departure_time :date
#  return_time    :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class TourDetail < ApplicationRecord
  belongs_to :tour
  has_many :booking_tours, dependent: :destroy
  validates :departure_time, :return_time, presence: true
  validate :check_time, if: -> { departure_time.present? && return_time.present? }

  private

  def check_time
    errors.add(:return_time, 'must not less than Departure time') if return_time < departure_time
  end
end
