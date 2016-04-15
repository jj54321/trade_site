class Newsletter < ActiveRecord::Base

  belongs_to :user
  has_many :trades

  validates :title, presence: true
  validates :content, presence: true 

  def trades_attributes=(trades_attributes)

    trades_attributes.each do |i, trade_attributes|
      if Trade.find_by_id(trade_attributes[:id])
        Trade.update(trade_attributes[:id], trade_attributes)
      elsif trade_attributes[:instrument] != ""
        self.trades.build(trade_attributes)
      end
    end


  end



  def open_positions?
    self.trades.open_trades.count > 0
  end

  def closed_positions?
    self.trades.closed_trades.count > 0
  end






end
