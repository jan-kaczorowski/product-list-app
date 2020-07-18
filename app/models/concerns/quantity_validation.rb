
module QuantityValidation
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      validates :quantity,
                presence: true,
                numericality: { 
                    greater_than_or_equal_to: base::MIN_QTY,
                    less_than_or_equal_to: base::MAX_QTY
                }
    end
  end

  module ClassMethods

  end
end