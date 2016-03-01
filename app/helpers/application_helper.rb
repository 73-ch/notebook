module ApplicationHelper
	def set_source
      @source = request.path
  end
end
