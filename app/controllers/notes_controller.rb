class NotesController < ApplicationController
  before_action :login_checker
  before_filter :set_request_from
  before_action :done_creater, only: [:index, :index_particle, :index_importance, :show, :edit]
  def new
    @note = Note.new
    categories = Category.where(user_id: session[:user_id])
    @categories = categories.all
  end

  def new_date
    @note = Note.new
    categories = Category.where(user_id: session[:user_id])
    @categories = categories.all  
  end

  def new_memo
    @note = Note.new
    categories = Category.where(user_id: session[:user_id])
    @categories = categories.all
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to "/index"
  end

  def create
    @now_time = DateTime.now
    @note = Note.create(note_params)
    @note.user_id = session[:user_id]
    @note.save
    notes_all = Note.where(user_id: session[:user_id], done: false)
    notes = []
    @notes = notes_all.order("start_time ASC")
    @notes_importance = notes_all.order("importance DESC").first
    @notes.each do |note|
      if note.start_time
        if note.start_time - 2.days <= @now_time
          notes.push(note)
          if notes.count == 3
            break
          end
        else
          @note_time = note
          break
        end  
      end
    end 
    @notes_count = notes.count
    if @notes_count == 0
      @note2 = @notes_importance
      @note3 = @note_time
    end
    if @notes_count == 1
      @note1 = notes[0]
      @note2 = @notes_importance
      @note3 = @note_time
    end
    if @notes_count == 2
      @note1 = notes[0]
      @note2 = notes[1]
      @note3 = @notes_importance
    end
    if @notes_count == 3
      @note1 = notes[0]
      @note2 = notes[1]
      @note3 = notes[2]
    end
    @categories = Category.all
  end

  def edit
    @note = Note.find(params[:id]) 
  end

  def show
    notes = Note.where(session[:user_id])
    @note = notes.find(params[:id])
    @note_processes = NoteProcess.where(note_id: params[:id])
  end

  def index 
    @now_time = DateTime.now
    notes_all = Note.where(user_id: session[:user_id], done: false)
    notes = []
    @notes = notes_all.order("start_time ASC")
    @notes_importance = notes_all.order("importance DESC").first
    @notes.each do |note|
      if note.start_time
        if note.start_time - 2.days <= @now_time
          notes.push(note)
          if notes.count == 3
            break
          end
        else
          @note_time = note
          break
        end  
      end
    end 
    @notes_count = notes.count
    if @notes_count == 0
      @note2 = @notes_importance
      @note3 = @note_time
    end
    if @notes_count == 1
      @note1 = notes[0]
      @note2 = @notes_importance
      @note3 = @note_time
    end
    if @notes_count == 2
      @note1 = notes[0]
      @note2 = notes[1]
      @note3 = @notes_importance
    end
    if @notes_count == 3
      @note1 = notes[0]
      @note2 = notes[1]
      @note3 = notes[2]
    end
    @categories = Category.all
  end

  def index_all
    @notes = Note.where(user_id: session[:user_id])
  end

  def index_date
    
  end

  def index_particle
    notes = Note.where(user_id: session[:user_id], done: false)
    @notes = notes.order("importance DESC")
  end

  def index_importance
    notes = Note.where(user_id: session[:user_id], done: false)
    @notes = notes.order("importance DESC")
  end
  def event_json
    events = Note.where.not(note_type: 2)
    @events = []
    events.each do |event|
      title = event.title
      url = "/notes/#{event.id}"
      start = event.start_time
      end_time = event.end_time
      if event.category
        color = event.category.color
      else
        color = "#FFF"
      end
      if event.note_type = 1
        allDay = true
      else
        allDay = false
      end
      @events.push(title: title, url: url, start: start, end: end_time, color: color, allDay: allDay)
    end
    render :json => @events
  end

  private
  def note_params
    params.require(:note).permit(:note_type, :title, :content, :importance, :start_time, :category_id, :end_time, :site_url)
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