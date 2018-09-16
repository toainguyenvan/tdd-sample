class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.string :name
      t.string :condition
      t.string :action

      t.timestamps
    end
  end
end
