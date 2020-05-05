class PortController < ApplicationController
  def show
    @port = Port.find(params[:id])
  end
end
