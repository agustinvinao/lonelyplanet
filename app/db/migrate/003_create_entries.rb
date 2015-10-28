class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :cdata, null: false
      t.integer :topic_id, null: false
      t.boolean :is_overview, default: false
      t.string :title, null: false
    end
  end
end