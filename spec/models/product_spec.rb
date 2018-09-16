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

require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { described_class.new }
  it "is valid with valid attributes" do
    subject.code = 'code'
    subject.name = 'name'
    subject.price = 1.1
    expect(subject).to be_valid
  end
  it "is not valid without a code" do 
    subject.name = 'name'
    subject.price = 1.1
    expect(subject).to_not be_valid
  end
  it "is not valid without a name" do 
    subject.code = 'code'
    subject.price = 1.1
    expect(subject).to_not be_valid
  end
  it "is not valid without a price" do 
    subject.code = 'code'
    subject.name = 'name'
    expect(subject).to_not be_valid
  end
end
