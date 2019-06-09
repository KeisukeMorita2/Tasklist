class TasksController < ApplicationController
  def index
     if logged_in?
      @task = current_user.tasks.build  
      @tasks = current_user.tasks.order(id: :desc)
     end
  end
  
  def show
    @tasks = Task.find(params[:id])
  end
  
  def new
    @tasks = Task.new
  end
  
  def create
    @tasks = current_user.tasks.new(task_params)
    
    if @tasks.save
      flash[:success] = 'Task が正常に作成されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'Task が作成できませんせした'
      render :new
    end
  end
  
  def edit
    @tasks = Task.find(params[:id])
  end
  
  def update
    @tasks = Task.find(params[:id])
    
    if @tasks.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'Task は正常に更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @tasks = Task.find(params[:id])
    @tasks.destroy
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
