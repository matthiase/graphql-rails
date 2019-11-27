class Vote < ApplicationRecord
  validates_uniqueness_of :user_id, scope: :product_id
  belongs_to :product
  belongs_to :user
end
