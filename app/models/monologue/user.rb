class Monologue::User < ActiveRecord::Base
  self.table_name = 'users'

  has_many :posts

  has_secure_password

  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email , presence: true, uniqueness: true

  def name
    [self.first_name, self.last_name].compact.join(' ')
  end

  def can_delete?(user)
    return false if self==user
    return false if user.posts.any?
    true
  end
end
