class AddDateToOperations < ActiveRecord::Migration[6.0]
  def change
    add_column :operations, :date, :string
    
  end
end
