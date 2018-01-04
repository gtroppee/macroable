module Macroable
  extend ActiveSupport::Concern

  included do
    class_attribute :node
    self.node = Node.new

    def self.add_macro(*names)
      names.each do |name|
        define_singleton_method(name.to_s.singularize) do |*args, &block|
          node.<<(name, args, block)
        end

        define_singleton_method(name) do |*args, &block|
          node.direct_children(name) || []
        end

        define_method(name.to_s.singularize) do |*args, &block|
          self.class.node.<<(name, args, block)
        end

        define_method(name) do |*args, &block|
          self.class.node.direct_children(name) || []
        end
      end
    end
  end
end
