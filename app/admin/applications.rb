ActiveAdmin.register Application do
  permit_params :user_id, :port_id, :flight_number, :arrival_on, :port_of_departure, :alternate_contact
end
