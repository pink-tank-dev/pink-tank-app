class UsersController < ApplicationController
  before_action :set_user, except: %i[index new create]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    if @user.valid?
      @user.save
      redirect_to @user, success: "#{@user.name} successfully created."
    else
      flash[:danger] = user_errors
      render :new
    end
  end

  def edit; end

  def edit_password; end

  def update
    @user.assign_attributes(update_params)
    if @user.valid?
      @user.save
      redirect_to @user, success: "#{@user.name} successfully updated."
    else
      flash[:danger] = user_errors
      render :edit
    end
  end

  def update_password
    @user.assign_attributes(update_params)
    if @user.valid?
      @user.save
      redirect_to @user, success: "Password successfully updated."
    else
      flash[:danger] = user_errors
      render :edit
    end
  end

  def show; end

  private

  def create_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:name, :email)
  end

  def update_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_errors
    @user.errors.full_messages.join(', ')
  end
end
