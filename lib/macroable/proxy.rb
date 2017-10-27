module Macroable
  class Proxy
    attr_accessor :registry, :key, :args, :block

    def initialize(params)
      params.each do |k, v|
        public_send("#{k}=", v)
      end
    end

    def save
      if child.present?
        child.items += [item]
      else
        self.registry = registry << new_registry
      end
      instance_eval(&block) if block.present?
    end

    def child
      @child ||= registry.find(key_sym)
    end

    def new_registry
      @new_registry ||= Registry.new(name: key_sym, items: [item])
    end

    def item
      Item.new(args)
    end

    def key_sym
      key.to_s.pluralize.to_sym
    end

    def method_missing(name, *args, &block)
      self.class.new(
        registry: registry, 
        key:      name, 
        args:     args, 
        block:    block
      ).save
    end
  end
end
