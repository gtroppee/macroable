module Macroable
  class Node < Base
    attr_accessor :parent, :children

    def initialize(params = {})
      super
      self.children = []
    end

    def direct_children(name)
      children.select { |c| c.name == name }
    end

    def all_children
      return [] unless children.any?
      children + children.flat_map(&:all_children)
    end

    private

    def method_missing(method_name)
      args[method_name] if args.is_a?(Hash) && args&.key?(method_name)
      return super if parent.all_children.none? { |c| c.name == method_name.to_s.singularize.to_sym }
      direct_children(method_name.to_s.singularize.to_sym)
    end

    def respond_to_missing?(method_name)
      args.is_a?(Hash) && args&.key?(method_name) || super
    end
  end
end
