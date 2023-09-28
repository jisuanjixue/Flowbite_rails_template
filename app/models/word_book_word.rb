class WordBookWord < ApplicationRecord
  belongs_to :word
  belongs_to :word_book
end
