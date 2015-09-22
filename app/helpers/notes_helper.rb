module NotesHelper
	def login_checker
		if session[:user_id] == nil
			redirect_to new_session_path
		end
	end

	def done_creater
		notes = Note.all
		notes.each do |note|
			if note.end_time
				if note.note_type == 0
					if note.end_time <= DateTime.now
						note.done = true
						note.save
					end
				else
					if note.end_time + 1.days <= Date.today
						note.done = true
						note.save
					end
				end
			end
		end
	end
end
