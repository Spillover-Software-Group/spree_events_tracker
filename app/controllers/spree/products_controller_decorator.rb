module Spree
  module ProductsControllerDecorator
    def self.prepended(base)
      base.include Spree::PageTracker
      base.track_actions [:show, :index]
    end
  end
end

if ::Spree::ProductsController.included_modules.exclude?(Spree::ProductsControllerDecorator)
  ::Spree::ProductsController.prepend Spree::ProductsControllerDecorator
end
