# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout 'projectic'
  before_filter :authorize, :except => :login
  helper :all # include all helpers, all the time
  

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'd55378dc3b36c802900daaf5b3785694'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
  
  protected
    def authorize
    
      puts self
      unless User.find_by_id(session[:user_id])
        flash[:notice] = "Please Log In"
        redirect_to :controller => 'admin', :action => 'login'
      end
    end
  
end
