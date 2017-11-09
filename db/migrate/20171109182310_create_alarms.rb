class CreateAlarms < ActiveRecord::Migration[5.1]
  def change
    create_table :alarms do |t|
      t.string :name
      t.string :reason
      t.integer :votes
      t.timestamps
    end
  end
end
