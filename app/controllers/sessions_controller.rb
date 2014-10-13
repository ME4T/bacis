class SessionsController < ApplicationController
  def new
  end

 def create
    user = User.find_by(email: params[:session][:email_or_username].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      user = User.find_by(username: params[:session][:email_or_username].downcase)
      if user && user.authenticate(params[:session][:password])
        sign_in user
        redirect_to user
      else
        flash.now[:error] = 'Invalid email/username and password combination'
        render 'new'
      end
    end
  end

  def destroy
  end
end
