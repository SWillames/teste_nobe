class AddInterestRateToOperation < ActiveRecord::Migration[6.0]
  def change
    add_column :operations, :interest_rate, :float, null: false, default: 0
  end
end
