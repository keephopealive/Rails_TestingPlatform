class AddColumnsToResultsScore < ActiveRecord::Migration
  def change
   	add_column :results, :email, :string
  end
end
