class AddTestIdToAnswersTable < ActiveRecord::Migration
  def change
    add_reference :answers, :test, index: true
  end
end
