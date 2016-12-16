class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User
  acts_as_messageable
  has_many :query_logs, dependent: :destroy
  has_many :keywords, through: :query_logs

  scope :member, ->{ where.not(name: 'guest' || nil) }
  scope :guest, ->{ where(name: 'guest') }

  extend Enumerize
  enumerize :role, in: ['admin']

  def admin?
    role == 'admin'
  end

  def soft_delete
    update!(email: "deleted-#{Time.now.to_i}#{rand(100)}-#{email}")
  end

  def self.create_with_omniauth(auth)
    user = User.new
    user.provider = auth['provider']
    user.uid = auth['uid']
    if auth['info']
       user.name = auth['info']['name'] || ""
       user.email = auth['info']['email'] || ""
       user.image = auth['info']['image'] || ""
    end
    user.create_new_auth_token
    user.save!(:validate => false)
  end

  def query(query_keyword)
    keyword = Keyword.where(keyword: query_keyword).first_or_create
    query_logs.where(keyword: keyword, created_at: Time.now.beginning_of_day..Time.now).first_or_create
  end

  def mailboxer_email(object)
    email
  end
end
