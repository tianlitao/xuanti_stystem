class Addscoretodesing < ActiveRecord::Migration
  def change
    add_column :designs , :score,:integer
  end
end
