class GithubService
  attr_reader :access_token

  def initialize(access_hash = {"access_token" => nil})
    @access_token = access_hash["access_token"]
  end

  def authenticate!(client_id, client_secret, code)
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: client_id, client_secret: client_secret,code: code}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    @access_token = access_hash["access_token"]
  end

  def get_username
    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    user_json["login"]
  end

  def get_repos
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
    repos = JSON.parse(response.body)
    repos.collect do |repo|
      GithubRepo.new(repo)
    end
  end

  def create_repo(params)
    response = Faraday.post "https://api.github.com/user/repos", {name: params}.to_json, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
  end
end
