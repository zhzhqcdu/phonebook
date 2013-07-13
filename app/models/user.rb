class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :rememberable, :trackable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable, :recoverable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :account, :password, :name, :email, :phone, :password_confirmation, :status

  validates_presence_of :account, :password, :email, :phone, :password_confirmation

  has_many :actor_users
  has_many :actors, :through => :actor_users
  
  belongs_to :membership

  def confirm_email?
    self.confirmation_token.blank?
  end

  def activate?
    self.status == 1 ? true : false
  end
end
