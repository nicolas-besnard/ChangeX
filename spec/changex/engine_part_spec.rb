require 'spec_helper'

describe Changex::EnginePart do
  describe ".new" do
    before do
      @engine_part_name  = 'EnginePartName'
      @engine_part_price = 5

      @engine_part = described_class.new(name: @engine_part_name, price: @engine_part_price)
    end

    it 'has a name' do
      expect(@engine_part.name).to eql(@engine_part_name)
    end

    it 'has a price' do
      expect(@engine_part.price).to eql(@engine_part_price)
    end
  end
end
