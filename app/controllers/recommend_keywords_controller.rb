class RecommendKeywordsController < ApplicationController
  def index

    keywords = RecommendKeyword.where.not(rank: nil)

    if keywords.present?
      render json: keywords, each_serializer: RecommendKeywordsSerializer
    else
      render :nothing => true, :status => 204 and return
    end
  end

end
