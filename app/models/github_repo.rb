class GithubRepo

  attr_reader :name, :url

  def initialize(args)
    @name = args["name"]
    @url = args["html_url"]
  end
end
