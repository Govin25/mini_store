class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show 
  end

  # new/create optional if Devise handles signup
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
end