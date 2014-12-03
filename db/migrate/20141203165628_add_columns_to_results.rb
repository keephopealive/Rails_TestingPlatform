class AddColumnsToResults < ActiveRecord::Migration
  def change
  	add_column :results, :first_name, :string
  end
end
