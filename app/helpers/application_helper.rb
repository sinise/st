module ApplicationHelper
	def flash_class(level)
		case level
		when :notice then "alert-info"
		when :success then "alert-success"
		when :error then "alert-danger"
		when :alert then "alert-danger"
		end
	end


	def nav_link(link_text, link_path)
	  class_name = current_page?(link_path) ? 'active' : ''

	  content_tag(:li, :class => class_name) do
	    link_to link_text, link_path
	  end
	end
end