class NotesController < ApplicationController
  before_action :login_checker
  before_filter :set_request_from
  before_action :done_creater, only: [:index, :index_particle, :index_importance, :index_day, :show, :edit]
  def new
    @type = params[:type]
    @source = params[:source]
    logger.info "@type is #{@type}"
    if params[:date]
      logger.info('read')
      @date = params[:date]
    else
      if @type == "plan"
        @date = DateTime.now
      elsif @type == "schedule"
        @date = DateTime.now
      end
    end
    @note = Note.new
    categories = Category.where(user_id: session[:user_id])
    @categories = categories.all
    @notes = Note.where(user_id: session[:user_id], done: false)
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to "/index_all"
  end

  def create
    @note = Note.create(note_params)
    @note.user_id = session[:user_id]
    @note.start_time = params[:note][:start_time]
    @note.end_time = params[:note][:end_time]
    if @note.note_type == 1
      @note.end_time += 1.days - 1.seconds
    end
    @note.save


    @source = params[:note][:source]
    case @source
    when "index_day"
      datetime = DateTime.now
      @plans = Note.where(user_id: session[:user_id], done: false, note_type: 0).where("start_time <= ? AND end_time >= ?", datetime, datetime)
      @schedules = Note.where(user_id: session[:user_id], done: false, note_type: 1).where("start_time <= ? AND end_time >= ?", datetime, datetime)
      @memos = Note.where(user_id:session[:user_id], done: false, note_type: 2)
      routines = Note.where(user_id:session[:user_id], done: false, note_type: 3)
      @routines = []
      routines.each do |routine|
        @routine.push(routine) if routine.routine.index(Date.today.wday)
      end
    when "index_calender"
    end
  end

  def edit
    @note = Note.find(params[:id])
    @categories = Category.where(user_id: session[:user_id])
  end

  def update
    @note = Note.find(params[:id])
    @note.update(note_params)
    redirect_to "/index_calender"
  end

  def show
    notes = Note.where(session[:user_id])
    @note = notes.find(params[:id])
    @note_processes = NoteProcess.where(note_id: params[:id])
  end

  def index_all
    @notes = Note.where(user_id: session[:user_id])
  end

  def index_calender
    @source = "index_calender"
  end

  def index_day
    datetime = DateTime.now
    logger.info "now time is #{datetime}"
    @plans = Note.where(user_id: session[:user_id], done: false, note_type: 0).where("start_time <= ? AND end_time >= ?", datetime, datetime)
    @schedules = Note.where(user_id: session[:user_id], done: false, note_type: 1).where("start_time <= ? AND end_time >= ?", datetime, datetime)
    @memos = Note.where(user_id: session[:user_id], done: false, note_type: 2)
    @source = "index_day"
    routines = Note.where(user_id:session[:user_id], done: false, note_type: 3)
    @routines = []
    routines.each do |routine|
      @routine.push(routine) if routine.routine.index(Date.today.wday)
    end
  end
  def date_json
    events = Note.where(user_id: session[:user_id]).where.not(note_type: 2)
    @events = []
    events.each do |event|
      title = event.title
      url = "/notes/#{event.id}"
      start = event.start_time
      end_time = event.end_time
      if event.category
        color = event.category.color
        text_color = event.category.opp_color
      else
        color = "#FFF"
        text_color = "#262626"
      end
      if event.note_type = 1
        allDay = true
      else
        allDay = false
      end
      @events.push(title: title, url: url, start: start, end: end_time, color: color, textColor: text_color, allDay: allDay)
    end
    render :json => @events
  end

  private
  def note_params
    params.require(:note).permit(:note_type, :title, :content, :importance, :category_id)
  end

  def set_request_from
    if session[:request_from]
      @request_from = session[:request_from]
    end
    # 現在のURLを保存しておく
    session[:request_from] = request.original_url
  end

  def return_back
    if request.referer
      redirect_to :back and return
    elsif @request_from
      redirect_to @request_from and return
    end
    return false
  end
end