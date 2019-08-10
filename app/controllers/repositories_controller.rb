class RepositoriesController < ApplicationController
  def index
    github = GithubService.new({access_token: session[:token]})
    @repos_array = github.get_repos
  end

  def create
    redirect_to '/'
  end
end
