class GithubRepo
  attr_accessor :name, :url

  def initialize(arg)
    @name = arg["name"]
    @url = arg["html_url"]
  end
end
