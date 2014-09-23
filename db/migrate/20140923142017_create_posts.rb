class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :facebook_id
      t.string :name
      t.string :picture
      t.text :message
      t.text :description
      t.references :page, index: true

      t.timestamps
    end
  end
end
