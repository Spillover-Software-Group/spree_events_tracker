module Spree
  module CheckoutControllerDecorator
    def self.prepended(base)
      base.include Spree::CheckoutEventTracker
      base.after_action :track_order_state_change, only: :edit
      base.after_action :track_order_completion, only: :update, if: :confirm?
    end

    private
    def confirm?
      previous_state == 'payment' || 'confirm'
    end

    def track_order_completion
      activity = ''
      state = ''
      if @order.payment_state == 'paid'
        activity = :complete_order
        state = :complete
      elsif @order.payment_state == 'failed'
        activity = :failed
        state = :payment
      end
      track_activity(activity: activity, previous_state: previous_state, next_state: state)
    end

    def track_order_state_change
      unless previous_state == next_state
        track_activity(activity: :change_order_state, previous_state: previous_state, next_state: next_state)
      end
    end
    
  end
end

if ::Spree::CheckoutController.included_modules.exclude?(Spree::CheckoutControllerDecorator)
  ::Spree::CheckoutController.prepend Spree::CheckoutControllerDecorator
end
