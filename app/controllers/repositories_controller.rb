class RepositoriesController < ApplicationController

  def index
    @service = GithubService.new({"access_token" => session["access_token"]})
    @repos_array = @service.get_repos
  end

  def create

    @response = @service.create_repo(params['name'])
    redirect_to '/'
  end
end
