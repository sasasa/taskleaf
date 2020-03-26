class CreateSkillsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :skills_users do |t|
      t.references :skill, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :proficiency

      t.timestamps
    end
  end
end
