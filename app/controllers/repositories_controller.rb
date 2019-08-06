class RepositoriesController < ApplicationController
  def index
    new GithubService
    @repos_array = GithubService.get_repositories
  end

  def create
    new GithubRepo({params['name'], session[:token]})
    response = GithubRepo.create
    redirect_to '/'
  end
end
