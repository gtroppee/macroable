module Macroable
  class Collection
    attr_accessor :items

    def initialize(items)
      self.items = items
    end
  end
end
