class CheckOut
  attr_accessor :promotions_rule, :basket

  def initialize(promotion = nil)
    @promotions_rule = promotion || Promotion.all
    @basket = {
      all: { 
        total: 0,
        discount_percent: 0,
        quantity: 0 
      }
    }
  end

  def scan(code)
    item = Product.find_by(code: code)
    return calculate if item.nil?
    put_item_into_basket(item)
    check_promotions_rule(item)
    calculate
  end

  def total
    basket[:all][:total]
  end

  private
  def default_basket_item
    {
      quantity: 0,
      sub_total: 0,
      code: nil,
      price: 0,
      discount_percent: 0
    }
  end

  def put_item_into_basket(item)
    basket[item.code] ||= default_basket_item
    basket[item.code][:code] = item.code
    basket[item.code][:quantity] += 1
    basket[item.code][:price] = item.price
    basket[item.code][:sub_total] = basket[item.code][:quantity] * item.price
    basket[:all][:total] += item.price
  end

  def check_conditions_valid?(basket_item, promotion)
    return false if promotion.conditions.length == 0 || basket_item.nil?
    promotion.conditions.all? { |key, value|
      check_with_operator(basket_item[key], value)
    }
  end

  def check_promotions_rule(item)
    promotions_rule.each do |promotion|
      basket_item = promotion.type == 'PromotionType::Single' ? basket[item.code] : basket[:all]
      if check_conditions_valid?(basket_item, promotion)
        apply_promotion(basket_item, promotion.actions)
      end
    end
  end

  def check_with_operator(item, value)
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

  def apply_promotion(basket_item, actions)
    actions.each { |attribute, value| basket_item[attribute] = value }
  end

  def basket_total_per_item(item)
     (item[:quantity] * item[:price] * (100 - item[:discount_percent])/100).to_f.round(2)
  end

  def calculate_actual_basket
    basket[:all][:total] = (basket[:all][:total] * (100 - basket[:all][:discount_percent])/100).to_f.round(2)
  end

  def calculate
    basket[:all][:total] = 0
    basket.each { |key, item| 
      next if key == :all
      basket[:all][:total] += basket_total_per_item(item) 
    } 
    calculate_actual_basket
    puts 'Total price: ' "#{total}"
  end
end