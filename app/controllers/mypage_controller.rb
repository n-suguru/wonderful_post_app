class MypageController < ApplicationController
  before_action :set_article, only: %i[edit update destroy]

  def index
    @articles = Article.where(user_id: current_user.id)
  end

  def show
    @articles = current_user.articles
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
      redirect_to  mypage_index_path, notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.user != current_user
      redirect_to  mypage_index_path
    else
      if @article.update(article_params)
        redirect_to  mypage_index_path
      else
        render :edit
      end
    end
  end

  def destroy
    @article.destroy
    redirect_to  mypage_index, notice: "Article was successfully destroyed."
  end

  private
    def set_article
      @article = current_user.article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :user_id)
    end
end
