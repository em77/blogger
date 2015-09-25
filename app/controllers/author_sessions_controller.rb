class AuthorSessionsController < ApplicationController
  def new
  end

  def create
    if login(params[:email], params[:password])
      flash.notice = "Logged in successfully"
      redirect_back_or_to(articles_path)
    else
      flash.now[:alert] = "Login failed"
      render action: :new
    end
  end

  def destroy
    logout
    redirect_to(:authors, notice: "Logged out")
  end
end
