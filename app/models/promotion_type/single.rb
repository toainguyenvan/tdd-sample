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

class PromotionType::Single < Promotion
end
