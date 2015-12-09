class ArticlesController < ApplicationController
  def index
    @user = find_user(params[:user_id]) if !params["user_id"].blank?
    @articles = Article.all
  end

  def new
    @user = find_user(params[:user_id]) if !params["user_id"].blank?
    @article = Article.new
  end

  def create
    user_id = params[:user_id]
    @article = Article.new(article_params)
    @article.user_id = params[:user_id]
    if @article.save
      flash[:success] = "Article Created Successfully"
      redirect_to user_articles_path(user_id)
    else
      render :new
    end
  end

  def edit
    @user = find_user(params[:user_id]) if !params["user_id"].blank?
    @article = Article.find(params["id"])
  end

  def update
    @article = Article.find(params["id"])
    if @article.update(article_params)
      flash[:success] = "Article updated Successfully"
      redirect_to user_articles_path(params["user_id"])
    else
      render action: 'edit'
    end
  end

  def show
    @article = Article.find_by_id(params["id"])
    @comments = @article.comments
    respond_to do |format|
      #format.html # show.html.erb
      format.js # show.js.erb
    end
  end

  def destroy
    @article = Article.find_by_id(params["id"])
    @article.destroy
    redirect_to user_articles_path(params["user_id"])
  end

  private

  def find_user(id)
    user = User.find_by_id(id)
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
