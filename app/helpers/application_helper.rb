module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Gateway Gamer"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def whatType(input)
   if input == 1
     "Borrow"
   elsif input == 2
     "Lend"
   else
     "ERROR"
   end
  end
  
  def whatStat(input)
   if input == 1
     "Closed"
   elsif input == 0
     "Open"
   else
     "ERROR"
   end
  end
  
  def whichTransaction(input)
    if input == "1"
      "Passive" #+ input.to_s
    else
      "Active" #+ input.to_s
    end
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def filterable(options, title)
    select_tag("title", options_from_collection_for_select(options, "id", "name"))
  end

  def gravatar_for(user, options = { size: 50 })
       gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
       size = options[:size]
       gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
       image_tag(gravatar_url, alt: user.email, class: "gravatar")
  end
  
  def time_diff_in_natural_language(from_time, to_time)
    from_time = from_time.to_time if from_time.respond_to?(:to_time)
    to_time = to_time.to_time if to_time.respond_to?(:to_time)
    distance_in_seconds = ((to_time - from_time).abs).round
    components = []

    %w(year month week day).each do |interval|
      # For each interval type, if the amount of time remaining is greater than
      # one unit, calculate how many units fit into the remaining time.
      if distance_in_seconds >= 1.send(interval)
        delta = (distance_in_seconds / 1.send(interval)).floor
        distance_in_seconds -= delta.send(interval)
        components << pluralize(delta, interval)
      end
    end

    components.join(", ")
  end
  def page_entries_info(collection, options = {})
  entry_name = options[:entry_name] || (collection.empty?? 'item' :
      collection.first.class.name.split('::').last.titleize)
  if collection.total_pages < 2
    case collection.size
    when 0; "No #{entry_name.pluralize} found"
    else; "Displaying all #{collection.size} #{entry_name.pluralize}"
    end
  else
    %{Displaying %d - %d of %d #{entry_name.pluralize}} % [
      collection.offset + 1,
      collection.offset + collection.length,
      collection.total_entries
    ]
  end
end
  
end