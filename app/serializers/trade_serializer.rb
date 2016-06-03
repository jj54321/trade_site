class TradeSerializer < ActiveModel::Serializer
  attributes :id, :entry, :stop, :take_profit, :direction, :user_id, :newsletter_id, :created_at, :updated_at, :closed, :profitable, :name
  # , :instrument
  has_one :newsletter
end
