class TodosController < ApplicationController
  before_filter :find_user
  before_filter :find_todo_list
  
  def index
    respond_to do |wants|
      wants.json do
        render :json => @todo_list.todo_items
      end
    end
  end  
  
  def create
    todo_list = @current_user.todo_lists.find_by_id!(params[:todo_list_id])
    
    todo_item = todo_list.todo_items.build
    todo_item.text = params[:text]
    todo_item.todo_list = todo_list
    todo_item.save!
    
    respond_to do |wants|
      wants.json do
        render :json => {
          :success => !todo_item.new_record?,
          :todo_item => todo_item
        }
      end
    end
  end
  
private

  def find_todo_list
    @todo_list = TodoList.find_by_id!(params[:todo_list_id])
  end
end
