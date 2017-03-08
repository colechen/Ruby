class User < ApplicationRecord
  has_and_belongs_to_many :roles
  has_many :assignments
  has_many :projects, :through => :assignments
end
