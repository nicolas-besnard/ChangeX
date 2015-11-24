module Changex
  class EnginePart
    attr_reader :name, :price, :sub_components

    def initialize(name:, price:)
      @name  = name
      @price = price
      @sub_components = []
    end

    # Add an [Changex::EnginePart] as a sub_component
    #
    # @param [Changex::EnginePart] object
    #
    # @raise Changex::EnginePart::NotAnEnginePart
    def <<(object)
      if object.is_a?(self.class)
        @sub_components << object
      else
        raise NotAnEnginePart
      end
    end

    NotAnEnginePart = Class.new(StandardError)
  end
end
