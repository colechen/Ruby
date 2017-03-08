class Project < ApplicationRecord
  has_many :assignments, :dependent => :destroy
  has_many :users, :through => :assignments
  accepts_nested_attributes_for :assignments, :allow_destroy => true
end
