module Inboxes
class MessagesController < ApplicationController
  before_action :set_inbox

  def upvote
    @message = Message.find(params[:id])
    flash[:notice] = 'Upvoted!'
    if current_user.voted_up_on? @message
 
      @message.downvote_from current_user

    else current_user.voted_down_on? @message
      
      @message.liked_by current_user

    end
    redirect_to @inbox
  end

  def new
    @message = @inbox.messages.new
  end

  def create
    @message = @inbox.messages.new(message_params) 

    respond_to do |format|
      if @message.save
        format.html { redirect_to @inbox, notice: "Message was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    
    @message = Message.find(params[:id]) #can change to @inbox.messages.find
    @message.destroy
    respond_to do |format|
      format.html { redirect_to @inbox, notice: "Message was successfully destroyed." }
    end
  end

  private
    def set_inbox
      @inbox = Inbox.find(params[:inbox_id])
    end

    def message_params
      params.require(:message).permit(:body).merge(user: current_user)
    end
end
end