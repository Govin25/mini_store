class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[ show edit update destroy ]
  # before_action :check_supplier ...

  before_action :check_permission, only: [:edit, :update, :destroy]

  def index
    
    @products = Product.all
    @users = User.all
    @categories = Category.all
    @subcategories = Subcategory.all
    @cart_items = CartItem.all  
  end

  def show
  end

  def new
    @product = Product.new
    @users = User.all
    @selected_user_id = params[:user_id]
  end

  def create
    @product = Product.new(product_params)

    @product.user = User.find(params[:user_id])
    @product.subcategory = Subcategory.find(params[:subcategory_id])

    if @product.save
      redirect_to products_path, notice: "Product created successfully!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private    

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price)
  end

 
  def check_permission
    return if current_user.supplier?

    # customer → only own product
    unless @product.user_id == current_user.id
      redirect_to products_path, alert: "Not authorized!"
    end
  end
end