class Usuario < ApplicationRecord
  validates_uniqueness_of :email
  validates_presence_of :nome, :email
end
