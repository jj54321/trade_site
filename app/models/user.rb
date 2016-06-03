class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]


  has_many :newsletters
  has_many :list_items
  has_many :trades, through: :newsletters



  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def full_name
    self.first_name + self.last_name
  end

  def accuracy
    if self.trades.closed_trades.count == 0
      return "This Trader does not have a track record yet"
    else
      ((self.trades.closed_trades.profitable_trades.count.to_f/self.trades.closed_trades.count) * 100).to_s + "%"
    end
  end

  def open_positions?
    self.trades.open_trades.count > 0
  end

  def closed_positions?
    self.trades.closed_trades.count > 0
  end
end
