class GithubService
  attr_accessor :access_token

  def initialize(access_hash={})
    @access_token = access_hash.fetch(:access_token, access_hash["access_token"])
  end


  def authenticate!(client_id, client_secret, code)
    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': code }
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(response.body)
    @access_token = body["access_token"]
  end


#  def get_username
#    user_resp = Faraday.get("https://api.github.com/user") do |req|
#      req.headers['Authorization'] = @access_token
#      req.headers['Accept'] = 'application/json'
#    end
#    user_hash = JSON.parse(user_resp.body)
#    session[:username] = user_hash['login']
#  end

# http issue:
def get_username
  resp = Faraday.get 'https://api.github.com/user',
    {},
    {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
  user_hash = JSON.parse(resp.body)
  user_hash['login']
end




def get_repos
  resp = Faraday.get 'https://api.github.com/user/repos',
    {},
    {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
    repo_array = JSON.parse(resp.body) # array of hashes
    @repos = repo_array.map {|repo| GithubRepo.new(repo)} # on every iteration create and return new instance
end



def create_repo(name)
  resp = Faraday.post 'https://api.github.com/user/repos',
  { name: name }.to_json,
  {'Authorization' => "token #{self.access_token}", "Accept" => "application/json"}
end



end
