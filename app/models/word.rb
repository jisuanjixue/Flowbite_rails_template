class Word < ApplicationRecord
  belongs_to :wordbook
  has_many :word_statuses
end
