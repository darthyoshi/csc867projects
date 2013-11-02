class AppointmentsController < ApplicationController
  #GET /appointments/:month/:year
  def show
    @appointment = Appointment.where("month = ? AND year = ?", Integer(params[:month])-1, params[:year])
    respond_to do |format|
      format.json {
        render :json => @appointment.to_json
      }
    end
  end

  #POST /appointments/send
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.json { head :created }
      else
        format.json { head :unprocessable_entity }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:date, :month, :year, :time, :desc)
    end
end
