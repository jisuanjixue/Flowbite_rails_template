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
require 'rails_helper'

RSpec.describe Category do
  pending "add some examples to (or delete) #{__FILE__}"
end
