class CreateXymonSets < ActiveRecord::Migration
  def change
    create_table :xymon_sets do |t|
      t.string :name
      t.string :value
      t.string :desc
      t.timestamps null: false
    end
  end
end
