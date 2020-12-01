class CreateOperations < ActiveRecord::Migration[6.0]
  def change
    create_table :operations do |t|
      t.references :account, null: false, foreign_key: true
      t.string :kind
      t.string :recipient
      t.float :amount

      t.timestamps
    end
  end
end
