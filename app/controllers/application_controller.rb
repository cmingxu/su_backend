class ApplicationController < ActionController::Base
  # reset captcha code after each request for security

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery
end
