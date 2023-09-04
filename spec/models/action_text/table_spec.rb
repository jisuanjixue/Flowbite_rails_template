# == Schema Information
# Schema version: 20230828092716
#
# Table name: action_text_tables
#
#  id         :bigint           not null, primary key
#  content    :json             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe ActionText::Table do
  pending "add some examples to (or delete) #{__FILE__}"
end
