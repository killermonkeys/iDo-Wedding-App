class AddLine3RenameZip < ActiveRecord::Migration
  def up
    add_column :addresses, :line_3, :string
  end

  def down
    remove_column :addresses, :line_3
  end
end
