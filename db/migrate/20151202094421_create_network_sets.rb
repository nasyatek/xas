class CreateNetworkSets < ActiveRecord::Migration
  def change
    create_table :network_sets do |t|
      t.string :hostname
      t.string :address
      t.string :netmask
      t.string :network
      t.string :broadcast
      t.string :gateway
      t.string :file_path

      t.timestamps null: false
    end
  end
end
