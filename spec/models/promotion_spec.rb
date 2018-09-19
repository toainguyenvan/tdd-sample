# == Schema Information
#
# Table name: promotions
#
#  id         :integer          not null, primary key
#  name       :string
#  conditions :string
#  actions    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string
#

require 'rails_helper'

RSpec.describe Promotion, type: :model do
  subject { described_class.new }
  it "is valid with valid attributes" do
    subject.name = 'name'
    subject.conditions = {quantity: 1, sub_total: 2}
    subject.actions = {price: 8.5}
    expect(subject).to be_valid
  end
  it "is not valid without a name" do 
    subject.conditions = {quantity: 1, sub_total: 2}
    subject.actions = {price: 8.5}
    expect(subject).to_not be_valid
  end
  it "is not valid without a condition" do 
    subject.name = 'name'
    subject.actions = {price: 8.5}
    expect(subject).to_not be_valid
  end
  it "is not valid without an action" do 
    subject.name = 'name'
    subject.conditions = {quantity: 1, sub_total: 2}
    expect(subject).to_not be_valid
  end
end
