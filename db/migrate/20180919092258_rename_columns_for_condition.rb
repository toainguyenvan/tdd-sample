class RenameColumnsForCondition < ActiveRecord::Migration[5.1]
  def change
    rename_column :promotions, :condition, :conditions
    rename_column :promotions, :action, :actions
  end
end
