class ConversationsSerializer < ActiveModel::Serializer
  attributes :id, :subject, :updated_at, :status

  def status
    return '' if object.last_sender == object.originator
    '관리자가 답변했습니다.'
  end
end
