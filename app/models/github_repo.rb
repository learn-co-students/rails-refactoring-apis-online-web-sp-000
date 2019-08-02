class GithubRepo
    attr_accessor :name, :url

    def initialize(attr_hash)
        @name = attr_hash["name"]
        @url = attr_hash["html_url"]
    end
end