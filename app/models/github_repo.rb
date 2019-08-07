class GithubRepo
    attr_accessor :name, :url
  
    def initialize(args)
      @name = args["name"]
      @url = args["html_url"]
    end
end
  