class CreateIncomes < ActiveRecord::Migration[5.2]
  def change
    create_table :incomes do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.date :date

      t.timestamps
    end
  end
end
