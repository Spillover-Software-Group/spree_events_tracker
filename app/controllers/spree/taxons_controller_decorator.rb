module Spree
  module TaxonsControllerDecorator
    def self.prepended(base)
      base.include Spree::PageTracker
      base.track_actions [:show]
    end
  end
end

if ::Spree::TaxonsController.included_modules.exclude?(Spree::TaxonsControllerDecorator)
  ::Spree::TaxonsController.prepend Spree::TaxonsControllerDecorator
end
