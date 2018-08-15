class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :products
  has_many :manuals
  has_many :comments
  has_many :reviews
  has_one :userspec

  after_create :assign_default_role
  def assign_default_role
    emails = ['inamorfati@likelion.org', 'seokk1209@likelion.org', 'wjs7541@likelion.org', 'thrhdwk75@gmail.com']
    if emails.include? self.email
      self.add_role('admin')
    elsif
      self.add_role('normal')
    end
  end
end
