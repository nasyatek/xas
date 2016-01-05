class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.text :ip
      t.text :hostname
      t.boolean :status
      t.text :note
      t.text :index_number
      t.integer :group_id
      t.timestamps null: false
    end
  end
end
