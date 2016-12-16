class Content < ApplicationRecord
  has_many :query_logs
  has_many :member_query_logs, -> { joins(:user).where.not(users: {name: 'guest'}) }, class_name: QueryLog
  has_many :guest_query_logs, -> { joins(:user).where(users: {name: 'guest'}) }, class_name: QueryLog
  scope :query_logs, -> { where.not(query_logs_count: [nil, 0]) }
  scope :daily_query_logs, -> { where.not(daily_query_logs_count: [nil,0]) }

  acts_as_taggable
  acts_as_taggable_on :categories

  mount_uploader :contents_thumbnail, ContentsThumbnailUploader

  def self.ransackable_scopes(auth_object = nil)
    %i(category_taggings_tag_id)
  end
end
