class ApplicationController < ActionController::Base
 
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  private

    def authenticate_user
      @service = GithubService.new
      session["access_token"] = @service.authenticate!(ENV["GITHUB_CLIENT"], ENV["GITHUB_SECRET"], "20")
    end

    def logged_in?
      !!session[:token]
    end
end
