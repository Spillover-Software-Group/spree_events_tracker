module Spree
  module Cart
    module Event
      class Tracker < Spree::Event::Tracker
        attr_reader :target
        attr_accessor :activity, :quantity

        def initialize(arguments = {})
          super(arguments)
          @quantity = arguments[:quantity]
          @total = arguments[:total]
          @variant_id = arguments[:variant_id]
          @activity = arguments[:activity]
        end

        def track
          CartEvent.create(instance_values)
        end

      end
    end
  end
end
