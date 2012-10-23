class ApplicationController < ActionController::Base
  protect_from_forgery

  def find_user
    access_token = session[:access_token]
    puts "keys: #{session.keys}"
    puts "access_token: #{access_token}"

    return false if !access_token
    
    if @current_user = User.where(:access_token => access_token).first
      @current_user
    else
      false
    end        
  end
end
