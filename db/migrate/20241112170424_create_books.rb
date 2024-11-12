class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false

      t.integer :publication_year, null: false

      t.index %i[title author], unique: true

      t.timestamps
    end
  end
end
