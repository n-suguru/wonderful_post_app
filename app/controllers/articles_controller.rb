class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_article, only: %i[edit update destroy]

  # GET /articles
  def index
    if params[:title].present?
      @articles = Article.where('title LIKE ?', "%#{params[:title]}%").page(params[:page])
    else
      @articles = Article.all.page(params[:page])
    end
  end

  # GET /articles/1
  def show
    @article = Article.find(params[:id])
    @user = @article.user
  end

  # GET /articles/new
  def new
    @article =Article.new
  end

  # POST /articles
  def create
    @article = current_user.articles.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to @article, notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.user != current_user
      redirect_to articles_path
    else
      if @article.update(article_params)
        redirect_to articles_path
      else
        render :edit
      end
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: "Article was successfully destroyed."
  end

  private
    def set_article
      @article = current_user.articles.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :user_id, tag_ids: [])
    end

end
