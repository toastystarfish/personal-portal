
module ApplicationHelper
  # creates a <th> tag that when clicked will cycle through sorting options
  # for this column, label is a symbol for the text displayed,
  # and sort_by specifies the attribute to sort on if it is not equal to label
  def sortable_column_header label, sort_by: nil
    sort_by ||= label.downcase
    dirs     = ['asc', 'desc', nil]
    # get the current direction
    direction = params[:sort] ? params[:sort][sort_by] : nil

    if new_direction = dirs[(dirs.index(direction) + 1) % dirs.length]
      path = url_for(sort: {sort_by => new_direction})
    else
      path = url_for
    end

    content_tag :th, data: {sort: direction} do
      link_to label.to_s.titleize, path
    end
  end

  # Creates the html template for notifly to interact with
  def notifly_template
    data = { turbolinks_permanent: true }
    concat content_tag :div, nil, id: 'notifly', class: 'notice', data: data
    notifly_flash
  end

  # updates notifly with currently queued notices
  def notifly_flash
    javascript_tag do
      render partial: 'notifly/display_flash.js'
    end
  end
end
