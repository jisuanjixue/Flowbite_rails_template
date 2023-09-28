class WordBook < ApplicationRecord
  belongs_to :user
  has_many :word_book_words
  has_many :words, through: :word_book_words
end
 