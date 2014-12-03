class AlterResultsAddColumns < ActiveRecord::Migration
  def add
  	add_column :results, :first_name, :string
    add_column :results, :last_name, :string
    add_column :results, :email, :string
    add_column :results, :score, :string
    add_column :results, :test_id, :string
  end
end
