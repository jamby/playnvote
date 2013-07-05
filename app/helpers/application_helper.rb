module ApplicationHelper
  def active_header_link(*args)
    # Must be passed in like [controller, action] for this logic to work
    link_class = ''
    args.each do |arg|
      controller = arg[0]
      action = arg[1]
      link_class = 'active' if params[:action] == action and params[:controller] == controller
    end
    link_class
  end
end
