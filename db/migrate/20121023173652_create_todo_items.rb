class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.string :text
      t.belongs_to :todo_list
      t.timestamps
    end
  end
end
