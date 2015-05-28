class MessagesController < ApplicationController
  def create
    @user = Message.new(message_params)
    @user.from = current_user.id
    if @user.save
      redirect_to '/teacher/index'
    else
      render :back
    end
  end



  private
  def message_params
    params.require(:message).permit!
  end
end
