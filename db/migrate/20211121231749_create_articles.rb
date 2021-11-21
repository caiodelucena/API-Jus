class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.boolean :active
      t.string :published_at
      t.integer :category_id
    end
  end
end
