class Book < ApplicationRecord
  validates :title, :author, :publication_year, presence: true

  validates :title, uniqueness: { scope: :author }
end
