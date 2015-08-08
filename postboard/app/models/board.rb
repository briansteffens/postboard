class Board < ActiveRecord::Base
  has_secure_password

  has_many :post, -> { order(created_at: :desc)}, :dependent => :destroy
end
