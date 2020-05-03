class AddSeatNumberInContact < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :seat_number, :string
    add_column :contacts, :status, :string
  end
end
