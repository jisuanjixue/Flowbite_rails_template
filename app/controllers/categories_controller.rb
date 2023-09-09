class CategoriesController < ApplicationController
    before_action :set_category, only: %i[show edit update category]
    before_action :is_admin?, expect: %i[show index]

    def index
        @categories = Category.all
    end

    def show
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        respond_to do |format|
            if @category.save
            format.html { redirect_to category_url(@category), notice: 'Category was successfully'}
            format.json { render :show, status: :created, location: @category }
            else
            format.html { render :new, status: :unprocessable_entity}
            format.json { render json: @category.errors, status: :unprocessable_entity}
            end
        end
    end

    def update
        respond_to do |format|
            if @category.update(category_params)
                format.html { redirect_to category_url(@category), notice: 'Category was successfully updated.' }
                format.json { render :show, status: :ok, location: @category }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @category.errors, status: :unprocessable_entity } 
            end
        end
    end

    def destroy
        @category.destroy
        respond_to do |format|
            format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private

    def set_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name, :show_nav)
    end
end
