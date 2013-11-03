class AppointmentsController < ApplicationController
  #GET /appointments/:month/:year
  def show
    @appointment = Appointment.where("month = ? AND year = ?", Integer(params[:month])-1, params[:year])

    render :json => @appointment.to_json
  end

  #POST /appointments/send
  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      head :created
    else
      head :unprocessable_entity
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:date, :month, :year, :time, :desc)
    end
end
