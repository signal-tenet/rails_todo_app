class AddPriorityToTodoItem < ActiveRecord::Migration[6.0]
  def change
    add_column :todo_items, :priority, :string
  end
end
