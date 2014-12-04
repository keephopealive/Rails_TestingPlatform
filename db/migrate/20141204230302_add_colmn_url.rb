class AddColmnUrl < ActiveRecord::Migration
  def change
  	add_column :tests, :url, :string
  end
end
