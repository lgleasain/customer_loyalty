class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :rolable_id, :rolable_type, :name, :phone_number, :merchant
  # attr_accessible :title, :body

  belongs_to :rolable, polymorphic: true

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  def initialize_rolable_type
    unless ['customer', 'merchant'].include? self.rolable_type
      self.rolable_type = 'customer'
    end
  end

  def create_merchant(merchant)
    self.rolable_id = merchant.id
  end

  def create_customer
    self.rolable_id = Customer.create.id
  end

  def is_merchant?
    self.rolable_type == "merchant"
  end

  def is_customer?
    self.rolable_type == "customer"
  end
end
