class AddDurationToAuthTokens < ActiveRecord::Migration
  def change
    add_column :auth_tokens, :duration, :string, :default => 'short'
  end
end
