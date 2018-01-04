module Macroable
  class Node < Base
    def initialize(params = {})
      super
      self.children = []
    end

    def direct_children(name)
      children.select { |c| c.namae == name }
    end

    def all_children
      return [] unless children.any?
      children + children.flat_map(&:all_children)
    end

    def <<(name, args, block)
      Proxy.new(parent: self, namae: name, args: args, block: block).node
    end

    private

    def method_missing(method_name)
      delegation(method_name)
    end

    def respond_to_missing?(method_name)
      delegation(method_name) || super
    end

    def delegation(method_name)
      return args.first[method_name] if args.first.is_a?(Hash) && args.first&.key?(method_name)
      return super if parent.all_children.none? { |c| c.namae == singular(method_name) }
      direct_children(singular(method_name))
    end

    def singular(symbol)
      symbol.to_s.singularize.to_sym
    end
  end
end
