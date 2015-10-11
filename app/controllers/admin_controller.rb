class AdminController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
	before_filter do 
    redirect_to :new_user_session_path unless current_user && current_user.admin?
  end
end

