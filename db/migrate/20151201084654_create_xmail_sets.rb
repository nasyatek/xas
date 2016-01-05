class CreateXmailSets < ActiveRecord::Migration
  def change
    create_table :xmail_sets do |t|
      t.string :name
      t.string :value
      t.string :desc
      t.timestamps null: false
    end
  end
end
