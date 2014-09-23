class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :facebook_id
      t.string :profile_picture
      t.string :name

      t.timestamps
    end
  end
end
