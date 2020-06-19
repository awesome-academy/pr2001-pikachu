# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  review_id  :integer          not null
#  user_id    :integer          not null
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
	belongs_to :user 
	belongs_to :review 
end
