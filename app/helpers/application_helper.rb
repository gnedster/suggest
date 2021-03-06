module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    style = column == sort_column ? "font-weight:bold" : nil
    link_to title, {:sort => column, :tag => params[:tag]}, {:style => style}
  end
end