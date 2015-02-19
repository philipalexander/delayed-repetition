class Card < ActiveRecord::Base
	belongs_to :user
	validates :front, presence: true, length: {minimum: 1}
end
