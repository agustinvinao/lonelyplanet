class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.integer :entries_count, default: 0
      t.integer :destination_id, null: false
    end
  end
end