class GithubService
    attr_accessor :access_token
    def initialize(access_hash=nil)

        if access_hash
            @access_token = access_hash["access_token"]
        end
    end

    def authenticate!(client_id, client_secret, code)
        url = "https://github.com/login/oauth/access_token"
        response = Faraday.post(url, {client_id: client_id, client_secret: client_secret, code: code}, {"Accept" => "application/json"})
        @access_token = JSON.parse(response.body)["access_token"]
    end
    
    def get_username
        url = "https://api.github.com/user"
        response = Faraday.get(url, {}, {'Authorization'=> "token #{@access_token}"})
        @username = JSON.parse(response.body)["login"]
    end

    def get_repos
        response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
        repo_hashes = JSON.parse(response.body)
        repo_hashes.collect{|hash| new GithubRepo(hash)}

    end

    def create_repo
    end

end