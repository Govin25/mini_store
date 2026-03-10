class SubcategoriesController < ApplicationController
    before_action :set_subcategory, only: %i[ show edit update destroy ]

    def index
        @subcategories = Subcategory.all
    end

    def new
        @subcategory = Subcategory.new
        @categories = Category.all
    end

    def show
    end

    def create
        @subcategory = Subcategory.new(subcategory_params)
        @category = Category.find_by(id:params[:subcategory][:category_id])
        @subcategory.category = @category
        if @subcategory.save
            redirect_to new_product_path(subcategory_id: @subcategory.id)
        else
            @categories = Category.all
            render :new
        end
    end

    def edit
        @categories = Category.all
    end

    def update
        if @subcategory.update(subcategory_params)
            redirect_to subcategories_path, notice: "Subcategory updated successfully!"
        else
            @categories = Category.all
            render :edit
        end
    end

    def destroy
        @subcategory.destroy
        redirect_to subcategories_path, notice: "Subcategory deleted successfully!"
    end

    private

    def set_subcategory
        @subcategory = Subcategory.find(params[:id])
    end

    def subcategory_params
        params.require(:subcategory).permit(:name)
    end

end
