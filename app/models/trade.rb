class Trade < ActiveRecord::Base
  belongs_to :newsletter
  belongs_to :user



  def self.open_trades
    self.where(closed: false)
  end

  def self.closed_trades
    self.where(closed: true)
  end



end
