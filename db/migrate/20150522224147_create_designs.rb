class CreateDesigns < ActiveRecord::Migration
  def change
    create_table :designs do |t|
      t.string :title
      t.string :demand
      t.integer :user_id
      t.integer :teacher

      t.timestamps null: false
    end
  end
end
