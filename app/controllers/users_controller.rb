class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @book = Book.new
    # @books = @user.books.page(params[:page]).reverse_order
    @books = Book.where(user_id: @user.id)
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week

    @users_count = User.group_by_day(:created_at).size
        # ユーザー登録数グラフ出力　gem groupdateをインストールしないと上記の記述は使用不可
    @user_today = User.where(created_at: Date.today.all_day).count
        # ユーザーの1日の登録数
  end

  def index
    @users = User.all
    @book = Book.new
  # 2.endがない
  end

  def edit
    @user = User.find(params[:id])
    # 他ユーザーのページの場合自分のページに移動
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end