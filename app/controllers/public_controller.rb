class PublicController < ApplicationController
  def index
  end


  protected

  #whitelist so login not required 
  def authorize
  end
  def authorize_admin
  end
  

  
end
