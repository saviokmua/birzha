module ApplicationHelper

# Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Подільська Товарна Біржа"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

 def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"   # Green
      when "error"
        "alert-danger"    # Red
      when "alert"
        "alert-warning"   # Yellow
      when "notice"
        "alert-info"      # Blue
      else
        flash_type.to_s
    end
  end

  def link_order title,field,order
    
    order=order.split
    order_field=order[0]
    order_type=order[1]
    if (field.to_s==order_field)
      if ("DESC"==order_type)
        order_type="ASC"
        order_icon="sort-by-attributes-alt"
      else
        order_type="DESC"
        order_icon="sort-by-attributes"
      end
    else
      order_field=field.to_s
      order_type="DESC"
    end
    order=order_field+" "+order_type
    link_to(title,'#',class: "form_search_order", data: {order: order}).to_s+' '+raw("<span class=\"glyphicon glyphicon-#{order_icon}\" aria-hidden=\"false\"></span>")
  end

def bootstrap_icon(type)
    case type.to_s
      when "show"
        action="eye-open"
      when "add"
        action="plus"
      when "edit"
        action="pencil"
      when "destroy"
        action="remove"
      else
        action=type
    end
      raw("<span class=\"glyphicon glyphicon-#{action}\" aria-hidden=\"true\"></span>")
  end


end
