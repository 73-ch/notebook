class NotesController < ApplicationController
  before_action :login_checker
  before_action :done_creater, only: [:index, :index_particle, :index_importance, :show, :edit]
  def new
    @note = Note.new
    categories = Category.where(user_id: session[:user_id])
    @categories = categories.all
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to notes_path
  end

  def create
    @note = Note.create(note_params)
    @note.user_id = session[:user_id]
    @note.save
  end

  def edit
    @note = Note.find(params[:id]) 
  end

  def show
    notes = Note.where(user_id: session[:user_id])
    @note = notes.find(params[:id])
  end

  def index 
    @now_time = DateTime.now
    notes_all = Note.where(user_id: session[:user_id], done: false)
    notes = []
    @notes = notes_all.order("start_time ASC")
    @notes_importance = notes_all.order("importance DESC").first
    @notes.each do |note|
      if note.start_time - 2.hours <= @now_time
        notes.push(note)
        if @notes.count == 3
          @note_time = note
          break
        end
      else
        @note_time = note
        break
      end
    end 
    @notes_count = notes.count
    if @notes_count == 0
      @note1 = "現在のノートはありません"
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

  def index_particle
    notes = notes = Note.where(user_id: session[:user_id], done: false)
    @notes = notes.order("importance DESC")
  end

  def index_importance
    notes = Note.where(user_id: session[:user_id], done: false)
    @notes = notes.order("importance DESC")
  end

  private
  def note_params
    params.require(:note).permit(:title, :content, :importance, :start_time, :category_id, :end_time, :alarm, :file, :site_url)
  end

end