class Post < ApplicationRecord
  extend FriendlyId
  validates :title, presence: true
  belongs_to :user
  enum :status, { draft: 0, underway: 1, done: 2, archived: 3 }

  friendly_id :title, use: %i[slugged history finders]

  def should_generate_new_friendly_id?
    title_changed? || slug.blank?
  end
end
