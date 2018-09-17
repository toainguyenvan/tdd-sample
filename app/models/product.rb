# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  code       :string
#  name       :string
#  price      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product < ApplicationRecord
  validates_presence_of :code, :name, :price
end
