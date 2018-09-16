# == Schema Information
#
# Table name: promotions
#
#  id         :integer          not null, primary key
#  name       :string
#  condition  :string
#  action     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string
#

class PromotionType::Multiple < Promotion
end
