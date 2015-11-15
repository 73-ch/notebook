class GroupNotesController < ApplicationController
  before_filter :set_request_from
  before_action :login_checker
  before_action :done_creater, only: [:index, :index_particle, :index_importance, :show, :edit]
  def new
    @group_note = GroupNote.new
    categories = GroupCategory.where(group_id: params[:group_id])
    @categories = categories.all
  end

  def new_date
    @group_note = GroupNote.new
    categories = GroupCategory.where(group_id: params[:group_id])
    @categories = categories.all  
  end

  def new_memo
    @group_note = GroupNote.new
    categories = GroupCategory.where(group_id: params[:group_id])
    @categories = categories.all
  end

  def destroy
    @group_note = GroupNote.find(params[:id])
    @group_note.destroy
    redirect_to "/index"
  end

  def create
    @group_note = GroupNote.create(group_note_params)
    @group_note.save
  end

  def edit
    @group_note = GroupNote.find(params[:id]) 
  end

  def show
    group_notes = GroupNote.where(session[:user_id])
    @group_note = group_notes.find(params[:id])
  end

  def index 
    @now_time = DateTime.now
    @group_notes_all = GroupNote.where(group_id: params[:group_id], done: false, group_note_type: [0,1,2])
    @categories = GroupCategory.all
  end

  def index_all
    @group_notes = GroupNote.where(group_id: params[:group_id])
  end

  def index_date
    
  end

  def index_particle
    group_notes = GroupNote.where(group_id: params[:group_id], done: false)
    @group_notes = group_notes.order("importance DESC")
  end

  def index_importance
    group_notes = GroupNote.where(group_id: params[:group_id], done: false)
    @group_notes = group_notes.order("importance DESC")
  end

  def event_json
    events = GroupNote.where.not(note_type: 2)
    @events = []
    events.each do |event|
      title = event.title
      url = "/group_notes/#{event.id}"
      start = event.start_time
      end_time = event.end_time
      if event.category
        color = event.category.color
      else
        color = "#FFF"
      end
      if event.group_note_type = 1
        allDay = true
      else
        allDay = false
      end
      @events.push(title: title, url: url, start: start, end: end_time, color: color, allDay: allDay)
    end
    render :json => @events
  end

  private
  def group_note_params
    params.require(:group_note).permit(:note_type, :title, :content, :importance, :start_time, :category_id, :end_time, :site_url, :group_id)
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
