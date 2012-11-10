class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :rolable_id, :rolable_type, :name, :phone_number
  # attr_accessible :title, :body

  belongs_to :rolable, polymorphic: true

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  before_create :create_child_class

  def initialize_rolable_type
    unless ['customer', 'merchant'].include? self.rolable_type
      self.rolable_type = 'customer'
    end
  end

  def create_child_class
    if self.valid?
      if self.rolable_type == "customer"
        self.rolable_id = Customer.create
      else
        self.rolable_id = Merchant.create
      end
    end
  end
end
