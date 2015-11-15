class Category < ActiveRecord::Base
	has_many :notes
	belongs_to :user
	validates :name, presence: true
end
