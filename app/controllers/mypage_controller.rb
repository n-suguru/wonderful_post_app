class MypageController < ApplicationController

  def show
    if params[:title].present?
      @articles = current_user.articles.where('title LIKE ?', "%#{params[:title]}%").page(params[:page])
    else
      @articles = current_user.articles.page(params[:page])
    end
  end
end
