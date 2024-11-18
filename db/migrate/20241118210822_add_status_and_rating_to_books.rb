class AddStatusAndRatingToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :rating, :integer, default: 0
    add_column :books, :status, :string, default: 'available'

    # add_check_constraint :books, 'rating between 0 and 5'
  end
end
