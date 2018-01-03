module Macroable
  class Node < Base
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

    def <<(name, args, block)
      Proxy.new(parent: self, name: name, args: args, block: block).node
    end

    private

    def method_missing(method_name)
      instance_eval(&delegation_proc)
    end

    def respond_to_missing?(method_name)
      instance_eval(&delegation_proc) || super
    end

    def delegation_proc
      proc {
        args[method_name] if args.is_a?(Hash) && args&.key?(method_name)
        return super if parent.all_children.none? { |c| c.name == singular(method_name) }
        direct_children(singular(method_name))
      }
    end

    def singular(symbol)
      symbol.to_s.singularize.to_sym
    end
  end
end
