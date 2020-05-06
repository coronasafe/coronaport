# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy, :summary, :set_red_flag, :print]
  before_action :application, only: [:show, :new, :edit, :update, :create, :summary, :set_red_flag, :print]

  # GET /contacts
  # GET /contacts.json
  def index
    # respond_to do |format|
    #   format.html
    #   format.csv { send_data @contacts.to_csv, filename: "requests-#{Date.today}.csv" }
    # end
  end

  def show
  end

  def new
  end

  def set_red_flag
    if current_user && current_user.is_admin?
      @contact.update!(status: 'red')
      redirect_to summary_application_contact_path(@application, @contact), notice: 'Flagged the traveller Successfully'
    else
      redirect_to root_path, notice: "You don't have admin access"
    end
  end

  def edit
  end

  def create
    @contact = @application.contacts.create(contact_params)
    @contact.user = current_user
    respond_to do |format|
      if @contact.save!
        Symptom.where(id: params['contact']['symptom_ids']).each do |s|
          ContactSymptom.create!(contact: @contact, symptom: s)
        end
        format.html { redirect_to application_contact_path(@application, @contact), notice: "Contact was successfully created." }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        @contact.contact_symptoms.destroy_all
        Symptom.where(id: params['contact']['symptom_ids']).each do |s|
          ContactSymptom.create!(contact: @contact, symptom: s)
        end
        format.html { redirect_to application_contact_path(@application, @contact), notice: "Contact was successfully created." }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def summary
    if current_user.is_admin?
      if @contact.arrived_on.blank?
        @contact.update!(arrived_on: Time.zone.now)
      end
    else
      redirect_to root_path, notice: "Access Denied! Only Admins are Allowed Access"
    end
  end

  def print
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact ||= application.contacts.find(params[:id])
  end

  def application
    @application ||= begin
      current_user.is_admin? ? Application.find(params[:application_id]) : current_user.applications.find(params[:application_id])
    end
  end

  def scope_access(contacts)
    if current_user.admin?
      contacts
    elsif current_user.district_admin?
      contacts
    elsif current_user.panchayat_admin?
      contacts.where(panchayat: current_user.panchayat)
    end
  end

  def panchayat
    Panchayat.find_by(lb_code: params[:contact][:lb_code])
  end

  # Only allow a list of trusted parameters through.
  def contact_params
    params.require(:contact).permit(:name, :passport_number, :phone, :gender, :age, :house_name, :ward, :landmark, :ration_type, :willing_to_pay, :number_of_family_members, :feedback, :user_id, :date_of_contact, :tracking_type, :panchayat_feedback,
      :has_diabetes,
      :has_hyper_tension,
      :has_heart_disease,
      :has_kidney_disease,
      :is_pregnant,
      :seat_number,
      :symptom_ids,
      :recent_history,
      :symptoms,
      :primary_contact,
      :has_tested,
      :was_positive,
      :test_type
    ).merge(panchayat_id: panchayat&.id)
  end
end
