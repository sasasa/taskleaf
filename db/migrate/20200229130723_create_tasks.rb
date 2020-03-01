class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name, limit: 30
      t.text :description
      t.timestamps
      t.index :name, unique: true
    end
  end
end
