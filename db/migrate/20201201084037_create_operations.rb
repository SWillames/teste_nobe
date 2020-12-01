class CreateOperations < ActiveRecord::Migration[6.0]
  def change
    create_table :operations do |t|
      t.referemces :account
      t.string :kind
      t.string :recipient

      t.timestamps
    end
  end
end
