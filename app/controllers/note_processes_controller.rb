class NoteProcessesController < ApplicationController
	before_action :login_checker
	def new
		@note_process = NoteProcess.new
	end
	def create
		@note_process = NoteProcess.create(note_process_params)
		@note_process.save

		@note_processes = NoteProcess.where(note_id: @note_process.note_id)
		length = @note_processes.count
		logger.info("#{length}")
	end
	def destroy
		@note_process = NoteProcess.find(params[:id])
		note_id = @note_process.note_id
		@note_process.destroy
		redirect_to "/notes/#{note_id}"
	end
	def edit
		@note_process = NoteProcess.find(params[:id])
	end
	def update
		@note_process = NoteProcess.find(params[:id])
		if @note_process.completed == false
			@note_process.update(completed: true)
		else
			@note_process.update(completed: false)
		end
		@note_process.save
		note_id = @note_process.note_id
		redirect_to "/notes/#{note_id}"
	end
	private
	def note_process_params
		params.require(:note_process).permit(:user_id, :note_id, :title)
	end
end
