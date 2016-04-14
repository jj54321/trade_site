class AddStatusToTrade < ActiveRecord::Migration
  def change
    add_column :trades, :closed, :boolean, default: false
  end
end
