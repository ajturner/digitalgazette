module ApplicationHelper

  def page_line page, &block
    "<li class='small_icon #{page.icon}%>_16'>#{yield}</li>"
  end

  # TODO: think about patching this in core
  # there was no possibility to pass :method => 'get' to pagination links
  def pagination_for(things, options={})
    return if !things.is_a?(WillPaginate::Collection)
    if request.xhr?
      defaults = {:renderer => LinkRenderer::Ajax, :previous_label => "&laquo; %s" % I18n.t(:pagination_previous), :next_label => "%s &raquo;" % I18n.t(:pagination_next), :inner_window => 2, :method => 'get'}
    else
      defaults = {:renderer => LinkRenderer::Dispatch, :previous_label => "&laquo; %s" % I18n.t(:pagination_previous), :next_label => "%s &raquo;" % I18n.t(:pagination_next), :inner_window => 2}
    end
    will_paginate(things, defaults.merge(options))
  end

  # i had problems, this does exactly, what i want 
  def better_hidden_field group, name, value
   "<input type='hidden' id='#{group}_#{name}' name='#{group}[#{name}]' value='#{value}' />"

  end
  
  
end
