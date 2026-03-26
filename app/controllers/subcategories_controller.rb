class SubcategoriesController < ApplicationController
  before_action :only_supplier, except: [:index, :show]
  before_action :set_subcategory, only: %i[show edit update destroy]
  before_action :authorize_owner, only: %i[edit update destroy]

  def index
    if current_user.supplier?
      @subcategories = current_user.subcategories   #  only own
    else
      @subcategories = Subcategory.all              # customer sees all
    end
  end

  def new
    @subcategory = Subcategory.new
    @categories = current_user.categories   #  only supplier's categories
  end

  def show
  end

  def create
    @subcategory = Subcategory.new(subcategory_params)
    @subcategory.user = current_user   #  owner

    if @subcategory.save
      redirect_to new_product_path(subcategory_id: @subcategory.id)
    else
      @categories = current_user.categories
      render :new
    end
  end

  def edit
    @categories = current_user.categories
  end

  def update
    if @subcategory.update(subcategory_params)
      redirect_to subcategories_path, notice: "Subcategory updated successfully!"
    else
      @categories = current_user.categories
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

  
  def authorize_owner
    unless @subcategory.user_id == current_user.id
      redirect_to subcategories_path, alert: "Not allowed"
    end
  end

  # only supplier can create/update/delete
  def only_supplier
    unless current_user.supplier?
      redirect_to root_path, alert: "Access denied"
    end
  end

  def subcategory_params
    params.require(:subcategory).permit(:name, :category_id)
  end
end