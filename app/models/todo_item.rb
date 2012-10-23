class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  
  validates_presence_of :text
  validates_presence_of :todo_list
end
