module Me::MessagesHelper
  def recipient_name_text_field_tag(recipient_name = nil)
    default_value =  recipient_name.blank? ? I18n.t(:message_recipient_name_input_caption) : recipient_name
    text_field_tag('id', params[:id], :id => 'recipient_name', :class => 'textinput',
                                        :value => default_value,
                                        :onkeypress => eat_enter,
                                        :onfocus => hide_default_value,
                                        :onblur => show_default_value)
  end

  def send_message_function(default_recipient_name = nil)
    submit_url = message_posts_path("__ID__")
    "submitNestedResourceForm('recipient_name', '#{submit_url}', #{default_recipient_name.blank?})"
  end

  def message_html_attributes(message)
    classes = %w(message)
    classes << 'unread' if message.unread_by?(current_user)
    { :id =>"message_#{message.id}", :class => classes.join(" ") }
  end

  def message_reply_html_attributes(message)
    if message.posts_count > 1 && message.replied_by == current_user
      {:class => 'reply'}
    else
      {}
    end
  end
  def action_bar_settings
    { :select =>
            [ {:name => :all,
               :translation => :select_all,
               :function => checkboxes_subset_function("tr.message .message_check_box", "tr.message .message_check_box")},
              {:name => :none,
                :translation => :select_none,
                :function => checkboxes_subset_function("tr.message .message_check_box", "")},
              {:name => :unread,
               :translation => :select_unread,
               :function => checkboxes_subset_function("tr.message .message_check_box", "tr.message.unread .message_check_box")}],
      :mark =>
            [ {:name => :read, :translation => :read},
              {:name => :unread, :translation => :unread}],
      :view =>
            [ {:name => :all, :translation => :all},
              {:name => :unread, :translation => :unread}] }
  end



end