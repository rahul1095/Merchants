class Merchant < ApplicationRecord
belongs_to :user, optional: :true
end
