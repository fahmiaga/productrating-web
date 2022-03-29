# == Schema Information
#
# Table name: stores
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Store < ApplicationRecord
    has_many :products
    
    validates :name, presence: true

    def store_rating
        Store.joins(products: [{purchases:  :review }]).where({id: self[:id]}).average(:rating).to_i
    end
end
