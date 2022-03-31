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
  has_one :review

  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :delivery_address, presence: true

  validate :check_quantity 

  # TODO: Implement this logic
  # - Return true if a review for this purchase exists in the database 
  # - Return false otherwise
  def review_exist?
    if Review.exists?(purchase_id: self.id)
      return true
    else
      return false
    end
  end

  def check_quantity(product, purchase_quantity)
    
    if product.quantity < 1 || product.quantity < purchase_quantity
      self.errors.add(:quantity, 'too few')
     end
  end

end
