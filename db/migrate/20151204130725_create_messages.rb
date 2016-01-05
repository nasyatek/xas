class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.string :body
      t.timestamp :attach

      t.timestamps null: false
    end
  end
end
