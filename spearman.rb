#!/usr/bin/env ruby

require 'set'

def aux(v)
  v.each_with_index.reduce({}) do |acc, xi|
    x, i = xi
    acc[x] = i
    acc
  end
end

def rankings(v)
  a = aux(v)
  vs = v.sort
  n = v.size
  0.upto(n - 1).map do |i|
    a[vs[i]]
  end
end

def spearman_same(u, v)
  raise 'both arrays must have the same size' unless u.size == v.size
  raise 'both arrays must have the same elements' unless u.to_set == v.to_set
  return 1 if u.size < 2
  a = aux(u)
  b = aux(v)

  n = v.size
  z =
    0.upto(n-1).sum do |i|
      rank_dif = b[u[i]] - i
      rank_dif * rank_dif # some definitions use rand_dif.abs and return z, e.g., https://rdrr.io/rforge/TopKLists/man/spearman.html
    end
  1 - 6.0*z/(n*(n**2-1))
end

def spearman(u, v)
  spearman_same(rankings(u), rankings(v))
end

if $PROGRAM_NAME == __FILE__
  require 'minitest/autorun'

  class MyTest < Minitest::Test
    def test_property_based
      1_000.times do
        u = Array.new(rand(1_000) + 1) { rand }
        v = u.shuffle
        assert_equal 1, spearman(u, u)
        assert_equal 1, spearman(v, v)
        assert spearman(u, v).between?(-1, 1)
        if u != v
          assert spearman(u, v) < 1
        end
      end
    end

    def test_example_based
      # https://statistics.laerd.com/statistical-guides/spearmans-rank-order-correlation-statistical-guide-2.php
      u = [56, 75, 45, 71, 62, 64, 58, 80, 76, 61]
      v = [66, 70, 40, 60, 65, 56, 59, 77, 67, 63]
      assert_in_delta spearman(u, v), 0.67, 0.01

      u = [10, 6, 5, 4, 1, 8, 2, 7, 9, 3]
      v = [10, 6, 7, 9, 4, 8, 5, 1, 2, 3]
      assert_in_delta spearman(u, v), 0.2, 0.01
    end
  end
end
