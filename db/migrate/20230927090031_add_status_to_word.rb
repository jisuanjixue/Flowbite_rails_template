class AddStatusToWord < ActiveRecord::Migration[7.0]
  def change
    add_column :words, :status, :integer, default: 0
  end
end
