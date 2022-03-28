class FavoritesController < ApplicationController
  before_action :authenticate_user!
  # リダイレクト先を削除、
  # リダイレクト先がない、かつJavaScriptリクエストという状況になり、
  # createアクション実行後は、create.js.erbファイルを、
  # destroyアクション実行後はdestroy.js.erbファイルを探すようになる

  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    # redirect_to request.referer
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    # redirect_to request.referer
  end
end
