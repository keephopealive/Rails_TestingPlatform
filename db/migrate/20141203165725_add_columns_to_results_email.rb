class AddColumnsToResultsEmail < ActiveRecord::Migration
  def change
   	add_column :results, :last_name, :string
  end
end
