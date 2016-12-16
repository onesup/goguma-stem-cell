class ReceiptsSerializer < ActiveModel::Serializer
  attributes :id, :is_read, :updated_at
  belongs_to :message
end
