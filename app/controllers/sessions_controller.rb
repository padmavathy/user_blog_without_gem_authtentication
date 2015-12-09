class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if user.email_confirmed
        session[:user_id] = user.id
        flash[:success] = 'Logged In!'
        redirect_to user_articles_path(user.id)
      else
        flash[:error] = 'Please activate your account by following the
        instructions in the account confirmation email you received to proceed'
      render :new
      end
    else
      flash[:error] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
