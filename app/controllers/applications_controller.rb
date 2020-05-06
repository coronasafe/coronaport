class ApplicationsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_application, only: [:show, :edit, :update]

  def index
    if current_user && current_user.is_admin?
      redirect_to ports_path
    else
      @applications = current_user&.applications
      if current_user && current_user.panchayat_admin?
        @houses = current_user.panchayat.houses.where(status: nil)
      end
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
    @application = Application.new
  end

  def edit
  end

  def create
    @application = Application.create(application_params)
    @application.user_id = current_user.id
    respond_to do |format|
      if @application.save
        format.html { redirect_to @application, notice: "Application was Successfully Created" }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to @application, notice: "Application was successfully updated." }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_application
    @application = Application.find(params[:id])
  end

  private

  def application_params
    params.require(:application).permit(:port_id, :flight_number, :arrival_on, :port_of_departure, :need_stay)
  end
end
