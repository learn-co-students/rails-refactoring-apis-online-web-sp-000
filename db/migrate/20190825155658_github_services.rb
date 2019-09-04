class GithubServices < ActiveRecord::Migration[5.0]
  def change
    create_table :github_services do |t|

      t.timestamps
    end
  end
end
