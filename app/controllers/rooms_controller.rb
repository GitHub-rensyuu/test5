class RoomsController < ApplicationController

   before_action :authenticate_user!

  def create
    @room = Room.create
    # 現在ログインしているユーザーのidと@roomのidを保存する
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    # ユーザーに押されたユーザーの情報保存、users/_infoのviewの@entryを保存するためpermitで許可
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    # チャットを開く
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    # Entryに既存のroom（現在ログインしているユーザーとroomの組み合わせがあるか）を確認
    if Entry.where(user_id: current_user.id,room_id: @room.id).present?
    # 条件がtrueだったら、Messageテーブルにそのチャットルームのidと紐づいたメッセージを表示させるため、@messagesにアソシエーションを利用した@room.messagesという記述を代入します。
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

end
