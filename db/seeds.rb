# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.delete_all
puts '..Deleted all Products'
Promotion.delete_all
puts '..Deleted all Promotions'

# Create test data
Product.create([
	{code: '001', name: 'Lavender heart', price: 9.25},
	{code: '002', name: 'Personalised cufflinks', price: 45.00},
	{code: '003', name: 'Kids T-shirt', price: 19.95}
])
puts '..Imported Product sample'

Promotion.create([
	{ name: 'buy_2_get_discount',
		type: 'PromotionType::Single', 
		condition: { quantity: {value: 2, operator: 'gte'}, 
						code: {value: '001', operator: 'e'}}, 
		action: {price: 8.5}},
	{ name: 'buy_more_than_60_get_10_percent_discount', 
		type: 'PromotionType::Multiple',
		condition: { total: { value:60 , operator: 'gte'}}, 
		action: { discount_percent: 10 }},
	{ name: 'buy_3_product_002_get_discount',
		type: 'PromotionType::Single', 
		condition: { quantity: {value: 3, operator: 'gte'}, 
						code: {value: '002', operator: 'e'}}, 
		action: {price: 40}}
])

puts '..Imported Promotion sample'
