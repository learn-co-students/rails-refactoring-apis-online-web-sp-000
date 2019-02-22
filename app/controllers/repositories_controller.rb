class RepositoriesController < ApplicationController
  
  @service

  def service
    @service ||= GithubService.new({'access_token' => session[:token]})
  end

  def index
    @repos_array = service.get_repos
  end

  def create

    redirect_to '/'
  end
end
