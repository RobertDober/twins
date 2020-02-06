RSpec.describe Twin do
  include Twin

  context "twin_pairs" do
    it "empty edge case" do
      expect(twin_pairs([],[])).to be_empty
    end

    it "a short example" do
      expect(
        twin_pairs(%w[a éléx alpha], %w[ab éxél phala])
      ).to eq(%w[No Yes Yes])
    end

    context "a longer example" do
      let(:as) {[
        "alpha", "beta", "", "4422", ""
      ]}
      let(:bs) {[
        "aleph", "teba", "", "2244", "é"
      ]}
      let(:expected) { %w[
        False True True True False
      ]}

      it {
        expect(twin_pairs(as, bs, yes: "True", no: "False")).to eq(expected)
      }

    end


  end
end
