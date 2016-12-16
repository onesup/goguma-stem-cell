module Api::V1
  module My
    class QueriesController < ApplicationController

      before_action :authenticate_user!

      def create
        @search = ransack_params
        @query_log = current_user.query(params[:q])
        render json: ransack_result, each_serializer: ContentsSerializer, query_log: @query_log
      end

      def update
        query_log = QueryLog.find params[:id]
        content = Content.find params[:content_id]
        query_log.content = content
        query_log.save
        render json: query_log.content, each_serializer: ContentsSerializer
      end

      private

      def ransack_params
        search = Content.includes(:categories)
        if params[:q].nil? || ActsAsTaggableOn::Tag.exists?(name: params[:q])
          @category_name = params[:q]
        end
        condition = :title_or_categories_name_cont
        search.ransack(condition => params[:q])
      end

      def ransack_result
        @search.result
      end

    end
  end
end
