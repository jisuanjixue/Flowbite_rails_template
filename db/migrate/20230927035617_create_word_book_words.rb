class CreateWordBookWords < ActiveRecord::Migration[7.0]
  def change
    create_table :word_book_words do |t|
      t.references :word, null: false, foreign_key: true
      t.references :word_book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
