class TodoList < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :text
  has_many :todo_items
end
