class AddSecondRsvp < ActiveRecord::Migration
  def up
    add_column :rsvps, :second_attending, :boolean
  end

  def down
    remove_column :rsvps, :second_attending
  end
end
