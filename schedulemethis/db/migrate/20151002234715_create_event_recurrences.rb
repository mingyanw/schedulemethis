class CreateEventRecurrences < ActiveRecord::Migration
  def change
    create_table :event_recurrences do |t|
      t.references :event, index: true, foreign_key: true
      t.boolean :even_weeks
      t.boolean :odd_weeks
      t.boolean :yearly
      t.string :months
      t.string :days
      t.boolean :auto_dismiss

      t.timestamps null: false
    end
  end
end
