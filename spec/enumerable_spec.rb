require './lib/enumerable_methods'

RSpec.describe Enumerable do
  describe "#my_each" do 
    it "returns the array" do
      expect([1, 2, 3].my_each { |x| puts x }).to eq([1, 2, 3])
    end

    it "outputs each member of the array" do
      expect { [1, 2, 3].my_each { |x| print x } }.to output("123").to_stdout
    end
  end
  
  describe "#my_select" do
    it "returns an array containing all elements of the input array for which the block has returned true" do
      expect([1, 2, 3].my_select { |x| x > 1 }).to eq([2, 3])
    end
  end

  describe "#my_all?" do
    it "returns true if the block returns true for each element of the array" do
      expect([1, 2, 3].my_all? { |x| x > 0 }).to eq(true)
    end

    it "returns false if the block returns false for each element of the array" do 
      expect([1, 2, 3].my_all? { |x| x > 5 }).to eq(false)
    end
  end

  describe "#my_any?" do
    it "returns true if the block returns true for any of the elements" do
      expect([1, 2, 3].my_any? { |x| x > 2 }).to eq(true)
    end

    it "returns false if the block doesn't return true for any of the elements" do
      expect([1, 2, 3].my_any? { |x| x > 5})
    end
  end

  describe "#my_count" do
    context "when block is not given" do
      it "returns the number of elements" do
        expect([1, 2, 3].my_count).to eql(3)
      end
    end
    
    context "when block is given" do
      it "returns the number of elements for which the block returns true" do
        expect([1, 2, 3].my_count { |x| x > 1}).to eql(2)
      end
    end
  end

  describe "#my_map" do
    it "creates a new array containing the values returned by the block" do
      expect([1, 2, 3].my_map { |x| x * 2}).to eq([2, 4, 6])
    end
  end
end