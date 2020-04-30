class AddDeadlineToTodoItem < ActiveRecord::Migration[6.0]
  def change
    add_column :todo_items, :deadline, :date
  end
end
