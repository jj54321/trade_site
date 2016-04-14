class Trade < ActiveRecord::Base
  belongs_to :newsletter
  belongs_to :user 
end
