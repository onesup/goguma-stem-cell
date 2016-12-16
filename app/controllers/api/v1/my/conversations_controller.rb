module Api::V1
  module My
    class ConversationsController < ApplicationController
      before_action :authenticate_user!
      before_filter :get_mailbox, :get_box, :get_actor
      before_filter :check_current_subject_in_conversation, :only => [:show, :update, :destroy]

      def index
        @conversations = @mailbox.conversations
        render json: @conversations, each_serializer: ConversationsSerializer
      end

      def show
        @receipts = @mailbox.receipts_for(@conversation).not_trash
        render json: @receipts, each_serializer: ReceiptsSerializer
        @receipts.mark_as_read
      end

      def create
        staffs = User.member.where(role: 'admin', provider: 'session')
        staffs.each do |staff|
          @actor.send_message(staff, params[:body], params[:subject])
        end

        render json: @mailbox.conversations, each_serializer: ConversationsSerializer
      end

      def update
        last_receipt = @mailbox.receipts_for(@conversation).last
        @receipt = @actor.reply_to_all(last_receipt, params[:body])
        @receipts = @mailbox.receipts_for(@conversation).not_trash
        render json: @receipts, each_serializer: ReceiptsSerializer
        @receipts.mark_as_read
      end

      def destroy

        @conversation.move_to_trash(@actor)

        respond_to do |format|
          format.html {
            if params[:location].present? and params[:location] == 'conversation'
              redirect_to conversations_path(:box => :trash)
    	else
              redirect_to conversations_path(:box => @box,:page => params[:page])
    	end
          }
          format.js {
            if params[:location].present? and params[:location] == 'conversation'
              render :js => "window.location = '#{conversations_path(:box => @box,:page => params[:page])}';"
    	else
              render 'conversations/destroy'
    	end
          }
        end
      end

      private

      def get_mailbox
        @mailbox = current_user.mailbox
      end

      def get_actor
        @actor = current_user
      end

      def get_box
        if params[:box].blank? or !["inbox","sentbox","trash"].include? params[:box]
          params[:box] = 'inbox'
        end

        @box = params[:box]
      end

      def check_current_subject_in_conversation
        @conversation = @mailbox.conversations.find_by_id(params[:id])

        if @conversation.nil? or !@conversation.is_participant?(@actor)
          redirect_to conversations_path(:box => @box)
        return
        end
      end

    end
  end
end
