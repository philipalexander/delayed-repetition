class Card < ActiveRecord::Base
	validates :front, presence: true, length: {minimum: 1}
end
