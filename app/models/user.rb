class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :newsletters
  has_many :trades, through: :newsletters

  def full_name
    self.first_name + self.last_name
  end

  def accuracy
    if self.trades.count == 0
      return "This Trader does not have a track record yet"
    else
      ((self.trades.closed_trades.count/self.trades.count) * 100).to_s + "%"
    end
  end

  def open_positions?
    self.trades.open_trades.count > 0
  end

  def closed_positions?
    self.trades.closed_trades.count > 0
  end
end
