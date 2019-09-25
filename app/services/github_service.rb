class GithubService
  attr_accessor :access_token

  def initialize(token={'access_token' => nil})
    @access_token = token['access_token']
  end

  def authenticate!(client_id, client_secret, code)

    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
     req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': code }
     req.headers['Accept'] = 'application/json'
    end

    access_hash = JSON.parse(resp.body)
    self.access_token = access_hash["access_token"]
  end

  def get_username
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{self.access_token}"
    end

    JSON.parse(resp.body)["login"]
  end

  def get_repos
    response = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers = { 'Authorization': "token #{self.access_token}", "Accept": 'application/json' }
    end

    repos = JSON.parse(response.body)
    r = repos.map { |repo| GithubRepo.new(repo) }
  end

  def create_repo(repo_name)
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.body = {name: repo_name}.to_json
      req.headers = { 'Authorization': "token #{self.access_token}", "Accept": 'application/json' }
    end
  end
end
