module Macroable
  class Registry
    attr_accessor :name, :items, :registries

    Enumerable.public_instance_methods.each do |method_name|
      define_method(method_name) do |*args, &block|
        items.public_send(method_name, *args, &block)
      end
    end

    def initialize(params = {})
      self.registries = []
      self.items      = []

      params.each do |k, v|
        public_send("#{k}=", v)
      end
    end

    def method_missing(method_name, *args)
      child = find(method_name)
      super unless child.present?
      child
    end

    def respond_to_missing?(method_name, *args)
      child = find(method_name)
      child.present? || super
    end

    def find(name)
      registries.detect do |registry| 
        registry.name == name
      end
    end

    def <<(other)
      self.registries << other
      other
    end

    ### move
    def last
      items.last
    end

    def size
      items.size
    end
  end
end
