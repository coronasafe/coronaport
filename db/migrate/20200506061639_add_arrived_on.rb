class AddArrivedOn < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :arrived_on, :datetime
  end
end
