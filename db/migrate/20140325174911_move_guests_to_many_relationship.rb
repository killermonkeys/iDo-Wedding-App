class MoveGuestsToManyRelationship < ActiveRecord::Migration
  def up
    remove_column :guests, :has_second_guest
    remove_column :guests, :g2_salutation
    remove_column :guests, :g2_first_name
    remove_column :guests, :g2_last_name
    remove_column :guests, :g2_suffix
    remove_column :guests, :g1_course1
    remove_column :guests, :g2_course1
    remove_column :guests, :g1_course2
    remove_column :guests, :g2_course2
    remove_column :guests, :g1_course3
    remove_column :guests, :g2_course3

    create_table :humans do |t|
      t.string :salutation, :first_name, :last_name, :suffix
      t.integer :ordinal
      t.belongs_to :guest
    end
    
  end

  def down

    add_column :guests, :has_second_guest, :string
    add_column :guests, :g2_salutation, :string
    add_column :guests, :g2_first_name, :string
    add_column :guests, :g2_last_name, :string
    add_column :guests, :g2_suffix, :string
    add_column :guests, :g1_course1, :string
    add_column :guests, :g2_course1, :string
    add_column :guests, :g1_course2, :string
    add_column :guests, :g2_course2, :string
    add_column :guests, :g1_course3, :string
    add_column :guests, :g2_course3, :string

    drop_table :guests
  end
end
