class RepositoriesController < ApplicationController
  
  @service

  def service
    @service ||= GithubService.new({'access_token' => session[:token]})
  end

  def index
    @repos_array = service.get_repos
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end
