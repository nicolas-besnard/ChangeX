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

    def find_instance(instance:)
      predicate = -> (part) {
        part == instance
      }

      find_first(predicate: predicate)
    end

    def find_all_sub_components_by_name(name:)
      predicate = -> (part) {
        part.name == name
      }

      find_all(predicate: predicate)
    end

    def find_all_sub_components_with_price(price:)
      predicate = -> (part) {
        part.price == price
      }

      find_all(predicate: predicate)
    end

    # Find the first element matching the predicate
    #
    # @param [Lambda] predicate
    #
    # @return [nil, Changex::EnginePart] Whether or not an Changex::EnginePart
    # is found
    def find_first(predicate:)
      found = self.sub_components.find(&predicate)

      if found
        return found
      else
        self.sub_components.each do |sub_component|
          found = sub_component.find_first(predicate: predicate)

          if found
            return found
          end
        end
      end

      nil
    end

    # Find all the element matching the predicate
    #
    # @param [Lambda] predicate
    #
    # @return [Array<Void>, Array<Changex::EnginePart] Whether or not
    # Changex::EnginePart are found
    def find_all(predicate:)
      found = []

      found += self.sub_components.select(&predicate)

      self.sub_components.each do |sub|
        found += sub.find_all(predicate: predicate)
      end

      if found.count == 0
        return []
      end

      found
    end

    NotAnEnginePart = Class.new(StandardError)
  end
end
