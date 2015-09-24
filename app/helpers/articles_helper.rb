module ArticlesHelper
  def article_params
    params.require(:article).permit(:title, :body, :tag_list, :image, 
      :author_id)
  end
end
