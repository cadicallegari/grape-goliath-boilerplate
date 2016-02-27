class Book < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 3 }

  validates :number_of_pages, presence: true
end
