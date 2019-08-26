class RepositoriesController < ApplicationController
  def index
    github_service = GithubService.new({:access_token=>session[:token]})
    github_service.access_token = session[:token]
    @repos_array = github_service.get_repos

  end

  def create
    github_service = GithubService.new({:access_token=>session[:token]})
    github_service.access_token = session[:token]
    github_service.create_repo(params[:name])
    redirect_to '/'
  end
end
