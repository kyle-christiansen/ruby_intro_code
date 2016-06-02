class Admin::CommentsController < ApplicationController

  http_basic_authenticate_with name: "Admin", password: "secret",
                               only: [:destroy, :index]


  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to :back  #Takes you back to where you were before
  end

  def index
    @comments = Comment.paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html
      format.json { render :json => @comments.to_json}
    end
  end



  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

end
