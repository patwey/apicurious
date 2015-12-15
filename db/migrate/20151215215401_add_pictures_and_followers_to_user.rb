class AddPicturesAndFollowersToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_pic, :string
    add_column :users, :banner_pic, :string
    add_column :users, :followers, :integer
    add_column :users, :following, :integer
  end
end
