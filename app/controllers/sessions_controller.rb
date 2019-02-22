class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    service = GithubService.new
    session[:token] = service.authenticate!(ENV["GITHUB_CLIENT"], ENV["GITHUB_SECRET"], params[:code])
    session[:username] = service.get_username
    redirect_to '/'
  end
  
end