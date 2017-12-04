class AddTeamIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :team_id, :integer
  end
end
