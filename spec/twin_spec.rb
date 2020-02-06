RSpec.describe Twin do

  include Twin

  def self.poor_mans_intersperse as, bs
    as.zip(bs).join 
  end

  context "method exposure" do
    it "the singleton exposes the same method as the module" do
      expect(described_class.method(:twin?).source_location).to eq(method(:twin?).source_location)
    end
  end

  context "strings of unequal length" do
    it "empty and not" do
      expect(twin?("", "a")).to be_falsy
    end
    it "not and emoty" do
      expect(twin?("ab", "")).to be_falsy
    end
    it "and not empty" do
      expect(twin?("aba", "ab")).to be_falsy
    end
  end

  context "of same length but not twins" do
    it "no x's in the b's even positions" do
      expect(twin?("xabab", "babab")).to be_falsy
    end

    context "let us generate some falsy cases" do
      evensa = %w[a é a é d]
      oddsa  = %w[x y 1 $ r]
      evensb = %w[A é a é d]
      oddsb  = %w[X y 1 $ r]


      15.times do |n|
        a = poor_mans_intersperse(
          evensa.sort_by{rand},
          oddsa.sort_by{rand})
        b = poor_mans_intersperse(
          evensb.sort_by{rand},
          oddsb.sort_by{rand})

        it "test not a twin ##{n}" do
          expect(twin?(a,b)).to be_falsy
        end
      end
    end
  end

  context "last but not least some twins" do

    it "yet again an edge case" do
      expect(twin?("","")).to be_truthy
    end

    it "a readable example (banana does not have many twins LOL" do
      expect(twin?("banana", "nabana")).to be_truthy
    end

    evens = %w[a é a é d]
    odds  = %w[x y 1 $ r]


    15.times do |n|
      a = poor_mans_intersperse(
        evens.sort_by{rand},
        odds.sort_by{rand})
      b = poor_mans_intersperse(
        evens.sort_by{rand},
        odds.sort_by{rand})

      it "test a twin ##{n}" do
        expect(twin?(a,b)).to be_truthy
      end
    end
  end

end
