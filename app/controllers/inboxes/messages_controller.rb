module Inboxes
  class MessagesController < ApplicationController
    before_action :set_inbox

    def upvote
      @message = Message.find(params[:id])
      @message.upvote! current_user
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            
            # turbo_stream.update('flash', partial: "shared/flash"),
            turbo_stream.replace(@message,
                                 partial: 'inboxes/messages/message',
                                 locals: { message: @message })
          ]
        end
        format.html { redirect_to @inbox, notice: 'Upvoted!' }
      end
    end

    def create
      @message = @inbox.messages.new(message_params)

      respond_to do |format|
        if @message.save
          format.turbo_stream do
            flash.now[:notice] = "Message #{@message.id} created!"
            render turbo_stream: [

              turbo_stream.update('new_message',
                                  partial: 'inboxes/messages/form',
                                  locals: { message: Message.new }),
              turbo_stream.update('message_counter', @inbox.messages_count),
              turbo_stream.prepend('message_list',
                                   partial: 'inboxes/messages/message',
                                   locals: { message: @message })
            ]
          end
          format.html { redirect_to @inbox, notice: 'Message was successfully created.' }

        else
          format.turbo_stream do
            flash.now[:alert] = 'Something went wrong...'
            render turbo_stream: [
              turbo_stream.update('new_message',
                                  partial: 'inboxes/messages/form',
                                  locals: { message: @message })
            ]
          end
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @message = Message.find(params[:id]) # can change to @inbox.messages.find
      @message.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @inbox, notice: 'Message was successfully destroyed.' }
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
