class CommentsController < ApplicationController

  def new
    @article = Article.find_by_id(params["article_id"])
    @user_id = params["user_id"]
    @comment = Comment.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.article_id = params[:article_id]
    if @comment.save
      flash[:success] = "Comment Created"
      redirect_to user_articles_path(params[:comment][:user_id])
    else
      respond_to do |format|
        format.js  render :new
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :user_id)
  end
end
