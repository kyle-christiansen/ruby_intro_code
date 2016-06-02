class Api::CommentsController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret",
                               only: [:destroy, :index]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  def index
    @comments = Comment.all
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
