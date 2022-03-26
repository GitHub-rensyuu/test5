class DropTableFavorites < ActiveRecord::Migration[6.1]
  def change
    drop_table :favorites do |t|
      t.integer "user_id"
      t.integer "book_id"
      t.timestamps null: false
    end

  end
end
