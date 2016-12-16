class ReceiptSerializer < ActiveModel::Serializer
  attributes :id, :is_read, :updated_at, :message
  belongs_to :message
end
