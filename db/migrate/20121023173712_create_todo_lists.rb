class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :text
      t.belongs_to :user
      t.timestamps
    end
  end
end
