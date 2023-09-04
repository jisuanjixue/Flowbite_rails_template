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
class ActionText::Table < ApplicationRecord
    include ActionText::Attachable

   attribute :content_type, :string, default: "text/html"

   def to_trix_content_attachment_partial_path
     "tables/editor"
   end

   def to_partial_path
     "tables/table"
   end

      def rows
     content.size
   end

   def columns
     content.map(&:size).max
   end

   def add_row(_index = rows - 1)
     content << Array.new(columns, "")
   end

   def remove_row(index = rows - 1)
     content.delete_at(index)
   end

   def add_column(_index = columns - 1)
     content.each do |row|
       row << ""
     end
   end

   def remove_column(index = columns - 1)
     content.each do |row|
       row.delete_at(index)
     end
   end
end
