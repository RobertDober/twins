module Twin extend self

  def twin_pairs as, bs, yes: "Yes", no: "No"
    as.zip(bs).map { |a, b|
      twin?(a, b) ? yes : no
    }
  end

  def twin? a, b
    return false unless a.size == b.size
    # The next optimization is asking for trouble ;)
    # but I also like the spirit to get rid of simple
    # cases first
    return true if a == b
    count(a) == count(b)
  end


  private

  def count a
    odds, evens = (1..2).map(&mk_counter)
    a
      .codepoints
      .each_slice(2) do |odd, even|
        odds[odd] += 1
        evens[even] += 1
    end
    [odds.freeze, evens.freeze]

  end

  def mk_counter
    -> (_) {
      Hash.new{|h, k| h[k]=0}
    }
  end
end
