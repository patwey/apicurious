class AddTweetsToUser < ActiveRecord::Migration
  def change
    add_column :users, :tweets, :string
  end
end
