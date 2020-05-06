class AddDistrictToContacts < ActiveRecord::Migration[6.0]
  class Panchayat < ActiveRecord::Base
  end

  def change
    add_column :panchayats, :lb_code, :string
    add_column :panchayats, :lb_type, :string
    add_column :panchayats, :lb_type_csn, :int
    add_column :panchayats, :lb_name_english, :string

    Panchayat.reset_column_information
    Panchayat.destroy_all
    response = HTTParty.get('https://raw.githubusercontent.com/coronasafe/datastore/master/JSON/Kerala_Local_Body.json')
    locations = JSON.parse(response.parsed_response)
    locations.each do |l|
      Panchayat.create!(
        district_id: l['district_id'],
        name: l['lb_name_full'],
        lb_code: l['lb_code'],
        lb_type: l['lb_type'],
        lb_type_csn: l['lb_type_csn'],
        lb_name_english: l['lb_name_english']
      )
    end
  end
end