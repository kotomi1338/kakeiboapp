class AddColumnToCost < ActiveRecord::Migration[5.2]
  def change
    add_column :costs, :date, :date
  end
end
