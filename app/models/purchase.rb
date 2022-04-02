# == Schema Information
#
# Table name: purchases
#
#  id               :bigint           not null, primary key
#  delivery_address :string
#  quantity         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_id       :bigint
#
# Indexes
#
#  index_purchases_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class Purchase < ApplicationRecord
  belongs_to :product
  has_one :review, dependent: :destroy

  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :delivery_address, presence: true

  # TODO: Implement this logic
  # - Return true if a review for this purchase exists in the database 
  # - Return false otherwise
  def review_exist?
    return Review.exists?(purchase_id: self.id)
  end

  def check_quantity(product, purchase_quantity)
    if product.quantity < 1 || product.quantity < purchase_quantity
      errors.add(:quantity)
    end
  end

end
