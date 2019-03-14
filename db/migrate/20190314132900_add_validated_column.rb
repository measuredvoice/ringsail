class AddValidatedColumn < ActiveRecord::Migration
  def change

    add_column :outlets, :validated_at, :datetime
    add_column :mobile_apps, :validated_at, :datetime
  end
end
