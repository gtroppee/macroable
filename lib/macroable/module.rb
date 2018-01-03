module Macroable
  extend ActiveSupport::Concern

  included do
    @node = Node.new

    class << self
      attr_accessor :node
    end

    def self.add_macro(*names)
      names.each do |name|
        define_singleton_method(name.to_s.singularize) do |*args, &block|
          @node.<<(name, args, block)
        end

        define_method(name.to_s.singularize) do |*args, &block|
          @node.<<(name, args, block)
        end

        define_singleton_method(name) do |*args, &block|
          node.direct_children(name) || []
        end

        define_method(name) do |*args, &block|
          self.class.node.direct_children(name) || []
        end
      end
    end
  end
end
