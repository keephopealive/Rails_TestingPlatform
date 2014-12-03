class AlterResultsTable < ActiveRecord::Migration
  def change
  	remove_column :results, :xml_result, :string
  end
end