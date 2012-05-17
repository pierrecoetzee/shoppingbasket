class CreateShoppingBaskets < ActiveRecord::Migration
  def change
    create_table :shopping_baskets do |t|

      t.timestamps
    end
  end
end
