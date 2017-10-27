module Macroable
  extend ActiveSupport::Concern

  included do
    @registry = Registry.new

    class << self
      attr_accessor :registry
    end

    def self.add_macro(*entries)
      entries.each do |entry|
        define_singleton_method(entry.to_s.singularize) do |*args, &block|
          register(registry, entry, args, block)
        end

        define_method(entry.to_s.singularize) do |*args, &block|
          self.class.register(registry, entry, args, block)
        end

        define_singleton_method(entry) do |*args, &block|
          registry.find(entry) || []
        end

        define_method(entry) do |*args, &block|
          self.class.registry.find(entry) || []
        end
      end
    end

    private

    def self.register(registry, key, args, block)
      Proxy.new(registry: registry, key: key, args: args, block: block).save
    end
  end
end
