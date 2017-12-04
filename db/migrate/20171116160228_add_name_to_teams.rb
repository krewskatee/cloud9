class AddNameToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :name, :string
  end
end
