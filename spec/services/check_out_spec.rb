require 'rails_helper'

describe CheckOut do
  products = Product.create([
    { code: '001', name: 'Lavender heart', price: 9.25 },
    { code: '002', name: 'Personalised cufflinks', price: 45.00 },
    { code: '003', name: 'Kids T-shirt', price: 19.95 }
  ])

  promotion = Promotion.create([
    { name: 'buy_2_get_discount',
      type: 'PromotionType::Single', 
      conditions: { quantity: {value: 2, operator: 'gte'}, 
           code: {value: '001', operator: 'e'}}, 
      actions: {price: 8.5}},
    { name: 'buy_more_than_60_get_10_percent_discount', 
      type: 'PromotionType::Multiple',
      conditions: { total: { value:60 , operator: 'gte'}}, 
      actions: { discount_percent: 10 }},
    { name: 'buy_3_product_002_get_discount',
      type: 'PromotionType::Single', 
      conditions: { quantity: {value: 3, operator: 'gte'}, 
             code: {value: '002', operator: 'e'}}, 
      actions: {price: 40}}
  ])

  subject {described_class.new(promotion)}

  it "Item not found" do 
    subject.scan("004")
    expect(subject.total).to eq(0)
  end

  it "One of 2 items not found" do 
    subject.scan("001")
    subject.scan("004")
    expect(subject.total).to eq(9.25)
  end

  it "Basket: 001,002,003" do
    subject.scan("001")
    subject.scan("002")
    subject.scan("003")
    expect(subject.total).to eq(66.78)
  end

  it "Basket: 001,003,001" do
    subject.scan("001")
    subject.scan("003")
    subject.scan("001")
    expect(subject.total).to eq(36.95)
  end

  it "Basket: 001,002,001,003" do
    subject.scan("001")
    subject.scan("002")
    subject.scan("001")
    subject.scan("003")
    expect(subject.total).to eq(73.76)
  end
end
