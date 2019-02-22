class RepositoriesController < ApplicationController
  
  @service

  def service
    @service ||= GithubService.new({'access_token' => session[:token]})
  end

  def index
    @repos_array = service.get_repos
  end

  def create
    service.create_repo(params[:name])
    redirect_to '/'
  end
end
