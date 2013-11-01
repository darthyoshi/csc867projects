class AppointmentsController < ApplicationController
  def show
    @appointment = Appointment.where("month = ? AND year = ?", Integer(params[:month])-1, params[:year])
    respond_to do |format|
      format.html
      format.json{
        render :json => @appointment.to_json
      }
    end
  end

  def create
    @appointment = Appointment.new(appointment_params)
  end
end

