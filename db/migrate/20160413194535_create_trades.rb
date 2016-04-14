class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.float :entry
      t.float :stop
      t.float :take_profit
      t.string :result
      t.string :instrument
      t.string :direction
      t.integer :user_id
      t.integer :newsletter_id

      t.timestamps null: false
    end
  end
end
