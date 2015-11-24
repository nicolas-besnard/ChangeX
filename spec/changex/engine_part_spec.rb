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

  describe "#find_first" do
    it "returns the first element matching the predicate" do
      engine_part_1 = described_class.new(name: "1", price: 10)
      engine_part_11 = described_class.new(name: "11", price: 5)
      engine_part_111 = described_class.new(name: "111", price: 2.5)

      engine_part_11 << engine_part_111
      engine_part_1 << engine_part_11

      ret = engine_part_1.find_first(predicate: -> (part) { part == engine_part_111 })

      expect(ret).to eql(engine_part_111)
    end
  end

  describe "#find_all" do
    context "there's a match" do
      it "returns all the element matching the predicate" do
        engine_part_1 = described_class.new(name: "1", price: 10)
        engine_part_11 = described_class.new(name: "11", price: 2.5)
        engine_part_111 = described_class.new(name: "111", price: 2.5)

        engine_part_11 << engine_part_111
        engine_part_1 << engine_part_11

        ret = engine_part_1.find_all(predicate: -> (part) { part.price == 2.5 })

        expect(ret).to eql([engine_part_11, engine_part_111])
      end
    end

    context "there's no match" do
      it "returns an empty array" do
        engine_part_1 = described_class.new(name: "1", price: 10)

        ret = engine_part_1.find_all(predicate: -> (part) { part.price == 2.5 })

        expect(ret).to eql([])
      end
    end
  end

  describe "#total_cost" do
    context "has 1 sub-component" do
      it 'returns the sum of the sub-component' do
        engine_part_1 = described_class.new(name: "1", price: 10)
        engine_part_11 = described_class.new(name: "11", price: 2.5)

        engine_part_1 << engine_part_11

        ret = engine_part_1.total_cost

        expect(ret).to eql(engine_part_11.price)
      end
    end

    context "has 2 sub-component" do
      it 'returns the sum of the sub-component' do
        engine_part_1 = described_class.new(name: "1", price: 10)
        engine_part_11 = described_class.new(name: "11", price: 2.5)

        engine_part_1 << engine_part_11
        engine_part_1 << engine_part_11

        ret = engine_part_1.total_cost

        expect(ret).to eql(engine_part_11.price * 2)
      end
    end

    context "engine part has 3 level" do
      it 'returns the sum of the sub-component' do
        engine_part_1 = described_class.new(name: "1", price: 10)
        engine_part_11 = described_class.new(name: "11", price: 5)
        engine_part_111 = described_class.new(name: "111", price: 2.5)

        engine_part_11 << engine_part_111
        engine_part_1 << engine_part_11

        ret = engine_part_1.total_cost

        expect(ret).to eql(5 + 2.5)
      end
    end
  end
end
