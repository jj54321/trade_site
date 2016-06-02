class AddNameToTrade < ActiveRecord::Migration
  def change
    add_column :trades, :name, :string
  end
end
