class PortsController < ApplicationController
  def show
    if current_user.is_admin?
      @port = Port.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def index
    unless current_user.is_admin?
      redirect_to root_path
    end
  end
end
