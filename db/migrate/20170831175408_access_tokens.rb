class AccessTokens < ActiveRecord::Migration
  def change
    add_column :outlets, :access_token, :string
  end
end
