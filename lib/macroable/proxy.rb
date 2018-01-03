module Macroable
  class Proxy < Base
    attr_accessor :block

    def node
      self.children = Node.new(name: name, args: args, parent: parent)
      instance_eval(&block) if block.present?
      parent.children << children
    end

    private

    def method_missing(name, *args, &block)
      children.<<(name, args, block)
    end
  end
end
