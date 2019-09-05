class RepositoriesController < ApplicationController
  def index
    service = GithubService.new({'access_token' => session[:token]})
    @repos_array = service.get_repos
  end

  def create
    service = GithubService.new({'access_token' => session[:token]})
    service.create_repo(params[:name])
    redirect_to '/'
  end
end
