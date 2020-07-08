# frozen_string_literal: true

# == Schema Information
#
# Table name: tours
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  price       :integer
#  category_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  coupon      :integer
#  seats       :integer
#
class Tour < ApplicationRecord
  belongs_to :category
  has_many :reviews
  has_many :ratings
  has_many :images
  has_many :tour_details
end
