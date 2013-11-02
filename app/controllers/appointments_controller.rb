class AppointmentsController < ApplicationController
  def show
    @appointment = Appointment.where("month = ? AND year = ?", Integer(params[:month])-1, params[:year])
    respond_to do |format|
      format.json {
        render :json => @appointment.to_json
      }
    end
  end

  def create
    rec = Appointment.create(date: params['date'], month: params['month'], year: params['year'], time: params['time'], desc: params['desc'])
    if rec != null
        result = {:status => 201}
    else
        result = {:status => 400}
    end
    render :json => result.to_json
  end
end
