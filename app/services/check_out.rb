class CheckOut
	attr_accessor :promotion_rules, :total
	attr_accessor :basket

	def initialize(promotion)
		@promotion_rules = promotion
		@basket = Hash.new()
		@basket['all'] = {total: 0, discount_percent:0, quantity: 0 }
		@total = 0
	end

	def scan(code)
		item = Product.find_by(code: code)
		return calculate if !item

		if !@basket[code]
			@basket[code] = {quantity: 1, sub_total: item.price, code: code, price: item.price, discount_percent: 0}
		else
			@basket[code][:sub_total] += item.price
			@basket[code][:quantity] += 1
			@basket[code][:code] = code
			@basket[code][:price] = item.price
			@basket[code][:discount_percent] = 0
		end

		@basket['all'][:total] += item.price

		@promotion_rules.each do |promotion|
			data = promotion.type == 'PromotionType::Single' ? @basket[item.code] : @basket['all']
			has_promotion = checkPromotion(data, promotion.condition)
			if has_promotion == true
				applyPromotion(data, promotion.action)
			end
		end
		
		calculate
	end

	def checkOperator(item, value)
		checkWithOperator(item, value)
	end

	private
	def checkPromotion(data, condition)
		if condition.length > 0
			condition.each do |key, value|
				return false if data and !checkWithOperator(data[key], value)
			end
			return true
		end
		return false
	end

	def checkWithOperator(item, value)
		condition = false
		case value[:operator]
		when 'gt'
			condition = item > value[:value]
		when 'gte'
			condition = item >= value[:value]
		when 'lt'
			condition = item < value[:value]
		when 'lte'
			condition = item <= value[:value]
		else
			condition = item == value[:value]
		end
		return condition
	end

	def applyPromotion(item, action)
		action.each do |key, value|
			item[key] = value
		end
	end

	def calculate
		@total = 0
		@basket.each do |key, value|
			next if key == 'all'
			total_per_item = (value[:quantity] * value[:price] * (100 - value[:discount_percent])/100).to_f.round(2)
			@total += total_per_item
			@basket['all'][:total] = @total
		end

		@total = (@basket['all'][:total] * (100 - @basket['all'][:discount_percent])/100).to_f.round(2)
	end
end