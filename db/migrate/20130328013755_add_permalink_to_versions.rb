class AddPermalinkToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :permalink, :string
    add_index :versions, :permalink, unique: true
  end
end
