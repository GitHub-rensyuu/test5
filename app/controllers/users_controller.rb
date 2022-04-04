class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]



  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.where(user_id: @user.id)
    @following_users = @user.following_user
    @follower_users = @user.follower_user

    # DM機能
    # 現在ログインしているユーザーと、「チャットへ」を押されたユーザーをwhereで見つける
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    # 現在ログインしているユーザーでない場合に行う
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          # 現在ログインしているユーザーと、「チャットへ」を押されたユーザーが一緒のroomの場合
          # 既存のidのroomを定義
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      # roomがない場合
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end

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

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
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