module Changex
  class EnginePart
    attr_reader :name, :price

    def initialize(name:, price:)
      @name  = name
      @price = price
    end
  end
end
