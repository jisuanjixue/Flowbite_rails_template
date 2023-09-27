class CreateWordStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :word_statuses do |t|
      t.references :word, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
