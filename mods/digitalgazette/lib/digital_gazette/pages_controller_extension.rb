module DigitalGazette
  module PagesControllerExtension
    def self.included(base)
      base.instance_eval do
        skip_before_filter :login_required
        before_filter :public_or_login_required, :except => [:search]
      end
    end

    def public_or_login_required
      return true unless @pages
      !(@pages.collect {|p| p.public? }.include?(false)) or login_required
    end
  end
end
