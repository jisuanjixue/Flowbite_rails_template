class WordStatus < ApplicationRecord
  belongs_to :word
  belongs_to :user
  enum status: { unmastered: 0, mastered: 1 }
end
