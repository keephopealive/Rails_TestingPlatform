class AddColumnTimer < ActiveRecord::Migration
  def change
  	add_column :results, :overtime, :integer
  end
end
