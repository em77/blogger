class ArticlesController < ApplicationController
  before_filter :require_login, except: [:index, :show, :destroy]
  before_filter :correct_user, only: [:destroy, :edit]

  include ArticlesHelper

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.author_id = current_user.id
    @article.save
    flash.notice = "Article '#{@article.title}' was created!"
    redirect_to article_path(@article)
  end

  def edit
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    flash.notice = "Article '#{@article.title}' was updated!"
    redirect_to article_path(@article)
  end

  def destroy
    @article.destroy
    flash.notice = "Article '#{@article.title}' was deleted!"
    redirect_to articles_path
  end

  def correct_user
    @article = Article.find(params[:id])
    unless current_user.id == @article.author_id
      flash.notice = "You may only edit or delete your own articles"
      redirect_to article_path(@article)
    end
  end
end
