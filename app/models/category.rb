# == Schema Information
# Schema version: 20230908073820
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  show_nav   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  has_many :posts, dependent: :destroy
end
