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
    # if a @page_type is given, we only want to render this, so we have to overwrite
    # the current path, to exclue other page_types
    if options[:page_type]
      # if we pass a path option to will paginate, it will use it for creating the url
      # see lib/digital_gazette/will_paginate_ajax_link_renderer.rb
      options[:params] ||= {}
      options[:params][:path] = @naked_path.dup
      options[:params][:path].add_types!(options[:page_type])
      options[:params][:path].flatten!
    end
    will_paginate(things, defaults.merge(options))
  end

  # i had problems, this does exactly, what i want
  def better_hidden_field group, name, value
   "<input type='hidden' id='#{group}_#{name}' name='#{group}[#{name}]' value='#{value}' />"
  end

  def clean_javascript_string(string, quote)
    [quote, "\n"].inject(string) do |s, char|
      s.gsub(char, "\\#{char}")
    end
  end

  def dg_page_class(type)
    MODEL_NAMES[type.to_s].try(:constantize) || raise("No such page type: #{type.inspect}")
  end

  def dg_page_type(klass)
    PAGE_NAMES[klass.to_s] || raise("No such page class: #{klass.to_s}")
  end
end
