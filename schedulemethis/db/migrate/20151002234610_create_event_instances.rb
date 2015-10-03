class CreateEventInstances < ActiveRecord::Migration
  def change
    create_table :event_instances do |t|
      t.references :event, index: true, foreign_key: true
      t.boolean :completed
      t.boolean :dismissed
      t.datetime :scheduled_start
      t.datetime :scheduled_end
      t.string :location

      t.timestamps null: false
    end
  end
end
