# == Schema Information
# Schema version: 20230907060914
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  city       :string
#  country    :string
#  state      :string
#  street     :string
#  zip        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Address < ApplicationRecord
  db_belongs_to :user, inverse_of: :address
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :country, presence: true
end
