class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    client_id = ENV["GITHUB_CLIENT"]
    client_secret = ENV["GITHUB_SECRET"]
    code = params[:code]
    # binding.pry

    service = GithubService.new
    session[:token] = service.authenticate!(client_id,client_secret, code)
    service = GithubService.new({"access_token" => session[:token]})

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]
    

    redirect_to '/'
  end
end