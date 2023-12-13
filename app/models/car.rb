# == Schema Information
#
# Table name: cars
#
#  id                :bigint           not null, primary key
#  brand             :string
#  model             :string
#  price             :decimal(, )
#  production_year   :integer
#  cylinder_capacity :decimal(, )
#  mileage           :decimal(, )
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Car < ApplicationRecord
end
