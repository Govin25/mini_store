class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_supplier, only: [:new, :create]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner, only: [:edit, :update, :destroy]

  def index
    if current_user.supplier?
      @products = current_user.products   #  only own
    else
      @products = Product.all             #  customer sees all
    end

    @categories = Category.all
    @subcategories = Subcategory.all
    @cart_items = CartItem.all  
  end

  def show
  end

  def new
    @product = Product.new
    @selected_subcategory_id = params[:subcategory_id]
    @subcategories = current_user.subcategories   #  ONLY OWN
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user   #  IMPORTANT
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
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private    

  def set_product
    @product = current_user.supplier? #? current_user.products.find(params[:id]) : Product.find(params[:id])
  end

  def authorize_owner
     unless @product.user_id == current_user.id 
      redirect_to products_path, alert: "Not authorized!"
    end
  end

  def only_supplier
    unless current_user.supplier?
      redirect_to products_path, alert: "Only supplier can create product"
    end
  end

  def product_params
    params.require(:product).permit(:name, :price)
  end
end