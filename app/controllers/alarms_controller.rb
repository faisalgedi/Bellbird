class AlarmsController < ApplicationController
  before_action :set_alarm, only: [:show, :edit, :update, :destroy]

  # GET /alarms
  # GET /alarms.json
  def index
    @alarms = Alarm.all
  end

  # GET /alarms/1
  # GET /alarms/1.json
  def show
  end

  # GET /alarms/new
  def new
    @alarm = Alarm.new
  end

  # GET /alarms/1/edit
  def edit
  end

  # POST /alarms
  # POST /alarms.json
  def create
    @alarm = Alarm.new(alarm_params)
    require "net/http"
    require "uri"

    respond_to do |format|
      if @alarm.save
        format.html { redirect_to @alarm, notice: 'Alarm was successfully created.' }
        format.json { render :show, status: :created, location: @alarm }
        require "net/http"
        require "uri"
        uri = URI('http://www.handshake-bellbird.com/push')
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data({"alarm_id" => @alarm.name, "per_page" => "50"})
        #response = http.request(request)
      else
        format.html { render :new }
        format.json { render json: @alarm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alarms/1
  # PATCH/PUT /alarms/1.json
  def update
    respond_to do |format|
      if @alarm.update(alarm_params)
        format.html { redirect_to @alarm, notice: 'Alarm was successfully updated.' }
        format.json { render :show, status: :ok, location: @alarm }
      else
        format.html { render :edit }
        format.json { render json: @alarm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alarms/1
  # DELETE /alarms/1.json
  def destroy
    #@alarm.destroy
    respond_to do |format|
      format.html { redirect_to alarms_url, notice: 'Alarm was successfully Upvoted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alarm
      @alarm = Alarm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alarm_params
      params.require(:alarm).permit(:name, :reason, :votes)
    end
end
