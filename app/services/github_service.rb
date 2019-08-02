class GithubService
    attr_accessor :access_token

    def initialize(access_hash = nil)
        if !access_hash.nil?
            @access_token = access_hash["access_token"]
        end
    end

    def authenticate!(client_id, client_secret, code)
        response = Faraday.post "https://github.com/login/oauth/access_token", 
        {client_id: client_id, client_secret: client_secret, code: code}, 
        {'Accept' => 'application/json'}
        body = JSON.parse(response.body)
        @access_token = body["access_token"]
    end

    def get_username
        user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
        user_json = JSON.parse(user_response.body)
        @username = user_json["login"]

    end

    def get_repos
        @access_token = 1
        response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
        JSON.parse(response.body).collect do |repo|
            GithubRepo.new(repo)
        end
    end

    def create_repo(name)
        # binding.pry
        Faraday.post "https://api.github.com/user/repos", {name: name}.to_json, {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
    end
end