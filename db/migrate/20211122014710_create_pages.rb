class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.integer :number
      t.text :content
      t.integer :article_id
    end
  end
end
