class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.text :description
      t.float :value
      t.boolean :direction
      t.references :category, index: true
      t.references :account, index: true
      t.timestamps
    end
  end
end
