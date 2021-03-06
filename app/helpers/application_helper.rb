module ApplicationHelper
  ALERT_TYPES = [:error, :info, :success, :warning]
  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      next if message.blank?

      type = :success if type == :notice
      type = :warning   if type == :alert
      next unless ALERT_TYPES.include?(type)

      Array(message).each do |msg|
        text = content_tag(:div,
                 content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") + msg.html_safe, :class => "alert fade in alert-#{type}")
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

	def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

	def format_dec(val)
		if val
			number_with_delimiter('%.2f' % val)
		else
			''
		end
	end
end
