class ContentsSerializer < ActiveModel::Serializer
  attributes :id, :title, :price
  attributes :created_at, :updated_at, :contents_thumbnail
  attributes :query_log_update

  has_many :categories

  def query_log_update
    if @instance_options[:query_log].present?
      "/api/v1/my/queries/#{@instance_options[:query_log].id}?content_id=#{object.id}"
    else
      ""
    end
  end

  link :self do
    href content_path(object)
  end
end
