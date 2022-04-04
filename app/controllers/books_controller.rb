class BooksController < ApplicationController

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    # tweet詳細ページにアクセスするとPV数が1つ増える。
    impressionist(@book, nil, unique: [:ip_address])
  end

  def index
    @user = current_user
    @book = Book.new

    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day

    # whereで一週間のデータを取得するように指定
    # sortでいいねが多い順に並び変え
    @books = Book.includes(:favorites).
      sort {|a,b|
        b.favorites.includes(:favorites).where(created_at: from...to).size <=>
        a.favorites.includes(:favorites).where(created_at: from...to).size
      }
      # book一覧をPV数の多い順に並び替える。
    @rank_books = Book.order(impressions_count: 'DESC')
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @user = current_user
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
end
