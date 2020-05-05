ActiveAdmin.register Contact do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :phone, :gender, :age, :house_name, :ward, :landmark, :panchayat_id, :willing_to_pay, :ration_type, :feedback, :number_of_family_members, :date_of_contact, :tracking_type, :panchayat_feedback, :passport_number, :alternate_contact, :application_id, :user_id, :has_diabetes, :has_hyper_tension, :has_heart_disease, :has_kidney_disease, :is_pregnant, :recent_history, :symptoms, :primary_contact, :has_tested, :was_positive, :test_type, :seat_number, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :phone, :gender, :age, :house_name, :ward, :landmark, :panchayat_id, :willing_to_pay, :ration_type, :feedback, :number_of_family_members, :date_of_contact, :tracking_type, :panchayat_feedback, :passport_number, :alternate_contact, :application_id, :user_id, :has_diabetes, :has_hyper_tension, :has_heart_disease, :has_kidney_disease, :is_pregnant, :recent_history, :symptoms, :primary_contact, :has_tested, :was_positive, :test_type, :seat_number, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
