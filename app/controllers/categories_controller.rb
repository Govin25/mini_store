class CategoriesController < ApplicationController
  before_action :only_supplier, except: [:index, :show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner, only: [:edit, :update, :destroy]

  def index
    if current_user.supplier?
      @categories = current_user.categories   # 👈 only own
    else
      @categories = Category.all              # 👈 customer sees all
    end
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user   # 👈 IMPORTANT

    if @category.save
      redirect_to new_subcategory_path(category_id: @category.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def authorize_owner
    unless @category.user_id == current_user.id
      redirect_to categories_path, alert: "Not allowed"
    end
  end

  def only_supplier
    unless current_user.supplier?
      redirect_to root_path, alert: "Access denied"
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end