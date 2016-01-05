class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.text :name
      t.boolean :status
      t.integer :index_number
      t.text :note
      t.timestamps null: false
    end
  end
end
