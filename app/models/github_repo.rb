class GithubRepo
    attr_accessor :name, :url
    def initialize(attributes_hash = {})
        @name = attributes_hash["name"]
        @url = attributes_hash["html_url"]
    end
end