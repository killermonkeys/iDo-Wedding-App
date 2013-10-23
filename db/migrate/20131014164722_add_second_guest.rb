class AddSecondGuest < ActiveRecord::Migration
  def up
    #add second guest names column
    add_column :guests, :has_second_guest, :boolean, :default => false, :null => false
    add_column :guests, :g2_salutation, :string
    add_column :guests, :g2_first_name, :string
    add_column :guests, :g2_last_name, :string
    add_column :guests, :g2_suffix, :string

    #remove additional guest column
    remove_column :guests, :additional_names
  end

  def down
    add_column :guests, :additional_names, :string

    remove_column :guests, :has_second_guest
    remove_column :guests, :g2_salutation
    remove_column :guests, :g2_first_name
    remove_column :guests, :g2_last_name
    remove_column :guests, :g2_suffix

  end
end
