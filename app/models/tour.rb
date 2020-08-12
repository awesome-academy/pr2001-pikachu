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
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :tour_details, dependent: :destroy
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :price, :coupon, :seats, presence: true, numericality: true
  accepts_nested_attributes_for :images

  scope :search_name, lambda { |name|
    where("name like '%#{name}%'")
  }

  scope :order_by_price, ->(sort_key) { order(price: sort_key) }
  scope :find_by_category, ->(category_id) { where category_id: category_id }
end
