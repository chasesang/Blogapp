class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      # create a session to log in and log out
      flash[:notice] = "User Created!"
      redirect_to posts_path
    else
      flash[:alert] = "Something went wrong!"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    ensure_current_password_is_correct(@user, params[:user][:current_password]) and return

    if @user.update(user_params)
      redirect_to edit_user_path(@user), notice: "Update successful"
    else
      render :edit
    end
    # raise user_params.inspect
  end



  private

    def user_params
      params.require(:user).permit([:first_name, :last_name, :email, :password, :password_confirmation])
    end

    def ensure_current_password_is_correct(user, current_password_from_form)
      return unless user_params[:password].present? || current_password_from_form.present?

      if BCrypt::Password.new(user.password_digest) != current_password_from_form
        redirect_to(edit_user_path(user), notice: "Current password wasn't correct")
      end
    end

end
