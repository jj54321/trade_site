class Trade < ActiveRecord::Base
  belongs_to :newsletter
  belongs_to :user

  # validates :entry, :stop, :take_profit, numericality: true, allow_blank: true


  def self.open_trades
    self.where(closed: false)
  end

  def self.closed_trades
    self.where(closed: true)
  end

  def self.profitable_trades
    self.where(profitable: true)
  end



end
