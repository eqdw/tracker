# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout "bugs"

  before_filter :authorize, :except => [:login, :logout]
  before_filter :authorize_admin, :except => [:login, :logout]

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => '8f8373cf095a9e0a4a858012ce5856c0'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  protected
  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to_index(:notice => "Please log in")
    end
  end

  def authorize_admin
    unless session[:admin]
      
      redirect_to_index(:notice => "That area is for administrators only",
        :controller => session[:user_id] ? 'bugs':'public')
    end
  end
  

  def redirect_to_index(options)
    flash[:notice] = options.delete(:notice)
    redirect_to(:action => 'index',
    :controller => options[:controller] ? options.delete(:controller):'public')
  end
end
