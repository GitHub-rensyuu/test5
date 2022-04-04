class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    # @books = @user.books
    @book = Book.new
    # @books = Book.where(user_id: @user.id)
    @books = Book.where(user_id: @user.id).includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
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
