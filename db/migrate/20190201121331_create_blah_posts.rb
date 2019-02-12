class CreateBlahPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :blah_posts do |t|
      t.string :name

      t.timestamps
    end
  end
end
