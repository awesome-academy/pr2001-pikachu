# frozen_string_literal: true

# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  tour_id    :integer          not null
#  link       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Image < ApplicationRecord
  belongs_to :tour
end
