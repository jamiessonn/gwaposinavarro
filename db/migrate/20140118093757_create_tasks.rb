class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :category
      t.date :due_date
      t.boolean :is_completed

      t.timestamps
    end
  end
end
