class CreateMenuChoicesAndMusic < ActiveRecord::Migration
  def up
    add_column :guests, :g1_dietary_preference, :string
    add_column :guests, :g2_dietary_preference, :string

    add_column :guests, :g1_course1, :string
    add_column :guests, :g2_course1, :string
    
    add_column :guests, :g1_course2, :string
    add_column :guests, :g2_course2, :string
    
    add_column :guests, :g1_course3, :string
    add_column :guests, :g2_course3, :string
    
    add_column :guests, :music, :string
  end

  def down
    remove_column :guests, :g1_dietary_preference
    remove_column :guests, :g2_dietary_preference
    remove_column :guests, :g1_course1
    remove_column :guests, :g2_course1
    remove_column :guests, :g1_course2
    remove_column :guests, :g2_course2
    remove_column :guests, :g1_course3
    remove_column :guests, :g2_course3
    remove_column :guests, :music
    

  end
end
