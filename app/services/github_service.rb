class GithubService
    attr_accessor :access_token
    def initialize(attr=nil)
        if attr
            @access_token = attr["access_token"]
        end
    end

    def authenticate!(client_id, client_secret, code)
        resp = Faraday.post "https://github.com/login/oauth/access_token" do |req|
          req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': code }
          req.headers['Accept'] = 'application/json'
        end  
        body = JSON.parse(resp.body)
        self.access_token = body["access_token"]
   end

   def get_username
      resp = Faraday.get "https://api.github.com/user" do |req|
        req.headers['Authorization'] = "token #{self.access_token}"
        req.headers['Accept'] = 'application/json'
      end
      user_json = JSON.parse(resp.body)
      user_json["login"]
   end

   def get_repos
        resp = Faraday.get "https://api.github.com/user/repos" do |req|
            req.headers['Authorization'] = "token #{self.access_token}"
            req.headers['Accept'] = 'application/json'
        end
        repos = JSON.parse(resp.body)
        repos.map {|repo| GithubRepo.new(repo)}
   end

   def create_repo(name)
    resp = Faraday.post "https://api.github.com/user/repos", {name: name}.to_json, {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
   end
end


