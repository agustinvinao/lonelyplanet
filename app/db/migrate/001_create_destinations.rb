class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :atlas_id, null: false
      t.string :asset_id
      t.string :title, null: false
      t.string :titleascii, null: false
      t.integer :parent_id
    end
  end
end