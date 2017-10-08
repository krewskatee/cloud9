class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.integer :post_id
      t.string :ip_address

      t.timestamps
    end
  end
end
