class Wallet < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, message: ' deve ser preenchido',
                               uniqueness: { case_sensitive: false }
end
