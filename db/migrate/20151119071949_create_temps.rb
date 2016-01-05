class CreateTemps < ActiveRecord::Migration
  def change
    create_table :temps do |t|
      t.decimal :tempc, :precision => 4, :scale => 2
      t.decimal :tempf, :precision => 4, :scale => 2
      t.decimal :temph, :precision => 4, :scale => 2
      t.boolean :mark, default: false

      t.timestamps null: false
    end
  end
end
