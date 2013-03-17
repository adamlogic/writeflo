class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :doc

      t.timestamps
    end
    add_index :reviews, :doc_id
  end
end
