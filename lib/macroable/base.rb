module Macroable
  class Base
    attr_accessor :name, :args, :parent, :children

    def initialize(params = {})
      params.each do |k, v|
        public_send("#{k}=", v)
      end
    end
  end
end
