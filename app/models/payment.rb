class Payment < ApplicationRecord
  belongs_to :user
  enum status: %i[cancel book nap]
end
