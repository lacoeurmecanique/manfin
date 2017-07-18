class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.float :money
      t.references :user, index: true

      t.timestamps
    end
  end
end
