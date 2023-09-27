class AddEditableToWordBook < ActiveRecord::Migration[7.0]
  def change
    add_column :word_books, :editable, :boolean, default: false
  end
end
