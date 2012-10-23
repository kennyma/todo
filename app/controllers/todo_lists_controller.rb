class TodoListsController < ApplicationController
  before_filter :find_user
  
  def index
    respond_to do |wants|
      wants.json do
        render :json => @current_user.todo_lists
      end
    end
  end
end

