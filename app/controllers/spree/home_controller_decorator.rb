module Spree
  module HomeControllerDecorator
    def self.prepended(base)
      base.include Spree::PageTracker
      base.track_actions[:index]
    end
  end
end

if ::Spree::HomeController.included_modules.exclude?(Spree::HomeControllerDecorator)
  ::Spree::HomeController.prepend Spree::HomeControllerDecorator
end
