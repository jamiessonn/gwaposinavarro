class CommentsController < ApplicationController
  before_action :authorize
  def create
    @task = Task.find(params[:task_id])
    @comment = current_user.comments.build(comment_params)
    @comment.task = @task
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @task, notice: 'Yes. Totally. People care about your opinions. Wew.' }
        #format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        #format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
    
  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
