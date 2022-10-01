class AddStatusToLikes < ActiveRecord::Migration[5.0]
  def change
    add_column :likes, :status, :integer
  end
end
