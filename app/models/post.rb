# == Schema Information
# Schema version: 20230908073820
#
# Table name: posts
#
#  id             :bigint           not null, primary key
#  comments_count :integer
#  description    :text
#  slug           :string
#  status         :integer
#  title          :string
#  views          :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :bigint
#  user_id        :bigint           not null
#
# Indexes
#
#  index_posts_on_category_id  (category_id)
#  index_posts_on_slug         (slug) UNIQUE
#  index_posts_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  extend FriendlyId
  validates :title, presence: true
  belongs_to :user
  belongs_to :category
  has_rich_text :description
  enum :status, { draft: 0, underway: 1, done: 2, archived: 3 }
  has_many_attached :images
  has_many :comments, dependent: :destroy

  has_noticed_notifications model_name: 'Notification'
  has_many :notifications, through: :user

  friendly_id :title, use: %i[slugged history finders]

  def should_generate_new_friendly_id?
    title_changed? || slug.blank?
  end

  def views_by_day
    daily_events = Ahoy::Event.where("cast(properties ->> 'post_id' as bigint) = ?", id)
    daily_events.group_by_day(:time, range: 1.month.ago..Time.now).count
  end

  def self.total_views_by_day
    daily_events = Ahoy::Event.where(name: 'Viewed Post')
    daily_events.group_by_day(:time, range: 1.month.ago..Time.now).count
  end

  def self.total_series
    []
  end

  def self.total_options
    {
      title: 'Viewed Post',
      subtitle: 'Grouped Per day',
      xtitle: 'day',
      ytitle: 'Properties',
      stacked: true
    }
  end
end
