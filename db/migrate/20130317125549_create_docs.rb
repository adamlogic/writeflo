class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.text :content
      t.string :permalink

      t.timestamps
    end
  end
end
