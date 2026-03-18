class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy]
  before_action :check_user_permission, only: [:show, :edit, :update, :destroy]

  def index
    @users = [ current_user ]
  end

  def show 
  end

  def edit
  end 

  def update
    
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    
    @user.destroy
    redirect_to users_path
  end

  private

  def set_user
    if params[:id] =~ /\A\d+\z/
      @user = User.find(params[:id])
    else
      redirect_to users_path, alert: "Invalid user"
    end
  end

  def user_params
    params.require(:user).permit(:name)
  end

  def check_user_permission
    
    return if @user.id == current_user.id
    
    redirect_to users_path, alert: "Not authorized!" and return
  end
end