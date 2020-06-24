# == Schema Information
#
# Table name: booking_tours
#
#  id             :integer          not null, primary key
#  tour_detail_id :integer          not null
#  user_id        :integer          not null
#  quantity       :integer
#  price_total    :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class BookingTour < ApplicationRecord
	belongs_to :tour_detail
	belongs_to :user	
end
