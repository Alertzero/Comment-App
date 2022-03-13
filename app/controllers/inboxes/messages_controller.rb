class Inboxes::MessagesController < ApplicationController
  before_action :set_inbox
  before_action :set_message, only: %i[ destroy ]

  # GET /messages/new
  def new
    @message = @inbox.messages.new
  end

  # POST /messages or /messages.json
  def create
    @message = @inbox.messages.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @inbox, notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy
    @message = Message.find(params[:id])
    respond_to do |format|
      format.html { redirect_to @inbox, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def :set_inbox
      @inbox = Inbox.find(params[:inbox_id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:body).merge(user: current_user)
    end
end
