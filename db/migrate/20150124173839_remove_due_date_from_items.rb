class RemoveDueDateFromItems < ActiveRecord::Migration
  def down
    remove_column :items, :due_date
  end
end
