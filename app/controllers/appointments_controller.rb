class AppointmentsController < ApplicationController
  def get
    @appointment = Appointment.where("month = ? AND year = ?", params[:month], params[:year])
  end

  def post
    @appointment = Appointment.new(appointment_params)
  end
end

