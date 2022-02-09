class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.references :user, null: false, foreign_key: true
      t.datetime :discarded_at

      t.timestamps
    end
    add_index :comments, :discarded_at
  end
end
