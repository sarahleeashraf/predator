class AdminController < ApplicationController
  def login
    
    if (session[:user_id] != nil)
      redirect_to(:controller => 'wells')
    end
    
    if request.post?
      user = User.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to(:controller => 'wells')
      else
        flash.now[:notice] = "Invalid email/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "logged out"
    redirect_to(:action => "login")
  end

  def index
  end

end
