class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :test_id
      t.string :xml_result

      t.timestamps
    end
  end
end
