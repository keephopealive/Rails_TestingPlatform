class AddColumnsToResultsTestName < ActiveRecord::Migration
  def change
  	add_column :results, :test_name, :string
  end
end
