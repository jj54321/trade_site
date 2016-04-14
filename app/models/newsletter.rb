class Newsletter < ActiveRecord::Base

  belongs_to :user
  has_many :trades

  def trades_attributes=(trades_attributes)
    trades_attributes.each do |i, trade_attributes|
      self.trades.build(trade_attributes)
    end
  end
end
