class Category < ActiveRecord::Base
	has_many :notes
	belongs_to :user
	validates :category_name, presence: true
end
