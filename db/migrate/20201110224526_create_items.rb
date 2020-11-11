class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.text :opinion
      t.string :image_id
      t.integer :user_id
      t.string :genre



      t.timestamps
    end
  end
end
