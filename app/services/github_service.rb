class GithubService
  attr_accessor :access_token

  def initialize(access_hash={})
    @access_token = access_hash['access_token']
  end

  def authenticate!(client, secret, code)
    response = Faraday.post "https://github.com/login/oauth/access_token",
                            {client_id: client, client_secret: secret,code: code},
                            {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    @access_token = access_hash['access_token']
  end

  def get_username
    response = Faraday.get "https://api.github.com/user",
                           {}, {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    access_hash['login']
  end

  def get_repos
    response = Faraday.get "https://api.github.com/user/repos",
                           {}, {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
    repos = JSON.parse(response.body)
    repo_list = repos.collect do |repo|
      GithubRepo.new({'name' => repo['name'], 'html_url' => repo['html_url']})
    end
    repo_list
  end

  def create_repo(repo_name)
    response = Faraday.post "https://api.github.com/user/repos",
                            {'name' => repo_name}.to_json,
                            {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
  end
end