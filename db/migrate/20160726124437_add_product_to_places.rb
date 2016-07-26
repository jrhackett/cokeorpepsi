class AddProductToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :product, :string
  end
end
