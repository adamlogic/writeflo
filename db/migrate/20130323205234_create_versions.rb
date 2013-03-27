class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.belongs_to :doc
      t.integer :number
      t.text :content

      t.timestamps
    end
    add_index :versions, :doc_id

    remove_index  :reviews, :doc_id
    rename_column :reviews, :doc_id, :version_id
    add_index     :reviews, :version_id

    remove_column :docs, :content
  end
end
