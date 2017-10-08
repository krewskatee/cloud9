class CreatePostVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :post_visits do |t|
      t.integer :visit_id
      t.integer :post_id

      t.timestamps
    end
  end
end
