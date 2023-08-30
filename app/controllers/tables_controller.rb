class TablesController < ApplicationController
  before_action :set_table, only: %i[show edit update destroy]
  layout false
 
   def edit
   end
  def create
    @table = ActionText::Table.create
 
    render json: {
      sgid: @table.attachable_sgid,
      content: render_to_string(partial: "tables/editor", locals: {table: @table}, formats: [:html])
    }
  end

     def update
      case params["operation"]
      when "addRow"
        @table.add_row
      when "removeRow"
        @table.remove_row
      when "addColumn"
        @table.add_column
      when "removeColumn"
        @table.remove_column
      when "updateCell"
        @table.content[params["row_index"].to_i][params["column_index"].to_i] = params["value"]
      else
        flash.alert = "Unknown table operation: #{params["operation"]}"
      end

      if @table.save
        respond_to do |format|
          format.html { redirect_to edit_table_path(id: @table.attachable_sgid) }
          format.json {}
        end
      else
        render :edit
      end
   end

   private

   def set_table
     @table = ActionText::Attachable.from_attachable_sgid params[:id]
   end
end
