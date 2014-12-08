class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :listing_id

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :listing_id
    add_index :relationships, [:follower_id, :listing_id], unique: true
  end
end
