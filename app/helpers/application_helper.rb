module ApplicationHelper

	def hidden_div_if(condition , attributes = {}, &block) 
		if condition 
			attributes["style"] = "display: none" # style will be display
		end
		content_tag("div",attributes, &block) # create <div id="cart"></div>
	end
end
