class UsersController < ApplicationController

  def index

  end

  def show
     @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
         UserMailer.delay.registration_confirmation(@user)
         flash[:success] = "Welcome! Please confirm your email address to continue"
         redirect_to root_path
      else
         render :new
      end
  end

  def edit
    flash = Array.new
    @user = User.find_by_id(params["id"])
  end

  def update
    @user = User.find_by_id(params["id"])
    if params["user"].present?
    @user.update_attribute(:cover_photo, params["user"]["cover_photo"])
    redirect_to user_articles_path(@user.id)
    else
      flash[:error] = "please upload a valid file"
      render :edit
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the User Blog! Your email has been confirmed.
      Please sign in to continue."
      redirect_to login_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
