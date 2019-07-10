class RepositoriesController < ApplicationController
  def index
    github = GithubService.new
    @repos_array = github.get_repos
  end

  def create
    github = GithubService.new
    @repos_array = github.create_repo
    redirect_to '/'
  end
end
