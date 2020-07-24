##Since you're not storing GithubRepo in a database,
##this class does not need to inherit from Active Record.
class GithubRepo

  attr_reader :name, :url

  def initialize(hash)
    @name = hash["name"]
    @url = hash["html_url"]
  end

end
