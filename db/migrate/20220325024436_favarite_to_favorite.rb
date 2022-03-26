class FavariteToFavorite < ActiveRecord::Migration[6.1]
  def change
    rename_table :favarites, :favorites
  end
end
