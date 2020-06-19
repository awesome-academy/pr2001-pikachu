# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  remember_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  admin           :boolean          default(FALSE)
#
class User < ApplicationRecord
	has_many :booking_tours
	has_many :reviews
	has_many :likes
	has_many :comments
	has_many :ratings
end
