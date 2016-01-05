class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.text :name
      t.text :value

      t.timestamps null: false
    end
  end
end
