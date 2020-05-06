class AddStayDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :applications, :need_stay, :boolean
  end
end
