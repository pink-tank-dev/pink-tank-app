module Admin
  class UsersController < ApplicationController
    before_action :set_user, except: %i[index new create]

    def index
      @users = User.all_except(current_user.id).order(id: :asc)
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(create_params.merge(password: temporary_password))
      if @user.save
        users_mailer.send_welcome_email(temporary_password: temporary_password)
                    .deliver_later
        redirect_to admin_user_path(@user), success: "#{@user.name} successfully created."
      else
        flash[:danger] = user_errors
        render :new
      end
    end

    def edit
      redirect_to users_path, warning: "User not found." unless @user.present?
    end

    def update
      @user.assign_attributes(update_params)
      if @user.save
        redirect_to admin_user_path(@user), success: "#{@user.name} successfully updated."
      else
        flash[:danger] = user_errors
        render :edit
      end
    end

    def edit_password
      redirect_to users_path, warning: "User not found." unless @user.present?
    end

    def update_password
      @user.assign_attributes(update_password_params)
      if @user.save
        redirect_to admin_user_path(@user), success: "Password successfully updated."
      else
        flash[:danger] = user_errors
        render :edit
      end
    end

    def show
      redirect_to admin_users_path, warning: "User not found." unless @user.present?
    end
    
    def reset_password
      @user.update(password: temporary_password)
      users_mailer.send_reset_password_email(temporary_password: temporary_password)
                  .deliver_later
    end

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

    def temporary_password
      @temporary_password ||= SecureRandom.hex(10)
    end

    def users_mailer
      UsersMailer.with(user_id: @user.id)
    end

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def user_errors
      @user.errors.full_messages.join(', ')
    end
  end
end
