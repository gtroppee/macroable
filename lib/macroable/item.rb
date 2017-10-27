module Macroable
  class Item
    attr_accessor :args

    def initialize(args)
      self.args = args[0].is_a?(Hash) ? args[0] : args
    end

    def evaluate(object = nil)
      (object || self).instance_eval(&block)
    end

    def method_missing(method_name)
      super unless args.is_a?(Hash) && args&.key?(method_name)
      args[method_name]
    end

    def respond_to_missing?(method_name)
      args.is_a?(Hash) && args&.key?(method_name) || super
    end
  end
end
