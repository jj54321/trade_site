class AddStatusToTrade < ActiveRecord::Migration
  def change
    add_column :trades, :closed, :boolean, default: false
    add_column :trades, :profitable, :boolean, default: false
  end
end
