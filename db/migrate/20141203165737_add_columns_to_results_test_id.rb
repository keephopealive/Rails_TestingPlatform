class AddColumnsToResultsTestId < ActiveRecord::Migration
  def change
  	add_column :results, :score, :string
  end
end
