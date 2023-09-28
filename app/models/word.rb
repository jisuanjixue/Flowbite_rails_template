class Word < ApplicationRecord
  has_many :word_book_words, dependent: :destroy
  has_many :word_books, through: :word_book_words
  enum status: { unmastered: 0, mastered: 1 }

  validates :name, presence: true

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= :unmastered
  end
end
