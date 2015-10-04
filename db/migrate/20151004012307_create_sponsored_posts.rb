class CreateSponsoredPosts < ActiveRecord::Migration
  def change
    create_table :sponsored_posts do |t|
      t.references :topic, index: true, foreign_key: true
      t.string :title
      t.text :body
      t.integer :price

      t.timestamps null: false
    end
  end
end
