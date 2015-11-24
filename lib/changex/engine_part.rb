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

    def to_s
      sub_components_count = self.sub_components.count

      if sub_components_count == 0
        return ''
      else
        ret = "The #{self.name} is composed of #{sub_components_count} elements:"
        self.sub_components.each do |sub_component|
          ret += "- #{sub_component.name}"
        end
        ret += " "
      end

      self.sub_components.each do |sub_component|
        ret += sub_component.to_s
      end

      ret
    end

    NotAnEnginePart = Class.new(StandardError)
  end
end
