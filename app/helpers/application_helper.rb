module ApplicationHelper

# Returns the full title on a per-page basis.
  def full_title(page_title)
    #base_title = "Подільська Товарна Біржа"
    base_title = Rails.application.config.birzha_settings[:name]
    if page_title.empty?
      base_title
    else
      " #{page_title} | #{base_title} "
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

def article_title(article)
  if article.auction_enable
    article.auction.name
  else
    article.title
  end
end

def article_content(article,preview=false)
  if article.auction_enable
    article.auction.started_at_date.to_s+" проводиться аукціон з реалізація майна. Детальна інформація "
  else
    if preview
      content=article.content.split("<!--more-->")
      content=content[0].to_s.html_safe
    else
      article.content.html_safe
    end
  end
end



def article_link(article,title="")
  if title=""
    title=article_title(article)
  end
  link_to title, article_url(article)
end

def article_url(article)
  unless article.auction_enable
    article_path(article)
  else
    auction_path(article.auction.id)
  end
end

def image_file_type (filename)
  if File.file?(filename)
    file_type=File.extname(filename)
    type=Rails.root.join('public/images/files_type/',file_type[1..100]+'.png')
    type_default='files_type/file.png'
    if File.file?(type)
      'files_type/'+file_type[1..100]+'.png'
    else
      type_default
    end
  end
end

def page_title page_id
  @page=Page.find_by(id: page_id)
  unless @page.nil?
    @page.title
  else
    "запис не знайдено"
  end
end

def link_to_page page_id
  link_to(page_title(page_id), page_path(page_id),target: "_blank")+("<br><br>").html_safe
end

def propoz propozs
  res = ''
  propozs.each do |propoz|
    unless propoz.html.empty?
      file_path||= Rails.root.join('public', 'uploads', 'propoz', propoz.filename) if propoz.filename.present?
      file_html_path = Rails.root.join('public', 'uploads', 'propoz', propoz.html)
      if File.file?(file_html_path)
       res+= link_to(propoz.title,('download/propoz/'+propoz.html))+" "+(link_to("(Скачати)", 'download/propoz/'+propoz.filename) if File.file?(file_path.to_s)) + ("<br><br>").html_safe
      end
    end
  end
  res.html_safe
end


end