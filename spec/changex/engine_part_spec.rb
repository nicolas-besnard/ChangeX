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

    it 'has an empty sub_components array' do
      expect(@engine_part.sub_components).to eql([])
    end
  end

  describe "#<<" do
    context "object is an EnginePart" do
      it "add the EnginePart as a sub_component" do
        engine_part = described_class.new(name: "EnginePartName", price: 10)
        sub_engine_part = described_class.new(name: "SubEnginePartName", price: 10)

        expect {
          engine_part << sub_engine_part
        }.to change(engine_part.sub_components, :count).by(1)
      end
    end

    context "object is not an EnginePart" do
      it "raises an exception" do
        engine_part = described_class.new(name: "EnginePartName", price: 10)

        expect {
          engine_part << "Foo"
        }.to raise_error(Changex::EnginePart::NotAnEnginePart)
      end
    end
  end
end
