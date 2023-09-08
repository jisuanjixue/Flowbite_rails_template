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
require 'rails_helper'

RSpec.describe Post do
  pending "add some examples to (or delete) #{__FILE__}"
end
