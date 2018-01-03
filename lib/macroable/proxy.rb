module Macroable
  class Proxy < Base
    attr_accessor :parent_node, :children_node, :block

    def node
      self.children_node = Node.new(name: name, args: args, parent: parent_node)
      instance_eval(&block) if block.present?
      parent_node.children << children_node
    end

    private

    def method_missing(name, *args, &block)
      Proxy.new(parent_node: children_node, name: name, args: args, block: block).node
    end
  end
end
