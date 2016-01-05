class CreateXapachiSets < ActiveRecord::Migration
  def change
    create_table :xapachi_sets do |t|
      t.string :name
      t.string :value
      t.string :desc
      t.timestamps null: false
    end
  end
end
