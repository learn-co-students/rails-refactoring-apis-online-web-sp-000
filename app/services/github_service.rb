class GithubService

  attr_reader :access_token

  def initialize(args=nil)
    @access_token = args["access_token"] if args
  end

  def authenticate!(client_id, client_secret, code)
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: client_id, client_secret: client_secret,code: code}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    @access_token = access_hash["access_token"]
  end

  def get_username
    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
    JSON.parse(user_response.body)["login"]
  end

  def get_repos
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
    JSON.parse(response.body).map{ |repo| GithubRepo.new(repo) }
  end

  def create_repo(name)
    response = Faraday.post "https://api.github.com/user/repos", {name: name}.to_json, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}

  end
end
