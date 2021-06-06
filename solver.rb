require_relative 'spearman'
alias correlation spearman_same

module Solver

  # == Parameters:
  # random_search_iterations::
  #   If a positive integer, indicates the number of random shuffle iterations to attempt.
  #   If nil or convertible to non-positive integer, search is exhaustive (all permutations).
  #
  # == Returns:
  # A Hash with the following structure
  #   {
  #     :best_corr_avg => highest average correlation score for the solution,
  #     :best => the solutions with such score
  #   }
  #
  def solve(names_orderings_map, random_search_iterations=nil)
    # consistency check
    if names_orderings_map.values.map(&:to_set).uniq.size != 1
      raise ArgumentError.new('incompatible orderings')
    end
    orderings = names_orderings_map.values

    choices = orderings[0]

    best = nil
    best_corr = -1.0 * orderings.size

    candidate_generator =
      if random_search_iterations.to_i > 0
        random_search_iterations.times.lazy.map { |i| choices.shuffle }
      else
        choices.permutation
      end

    candidate_generator.each do |candidate|
      cand_corr = orderings.sum { |member_ordering| correlation(candidate, member_ordering) }
      if cand_corr > best_corr
        best_corr = cand_corr
        best = [candidate]
      elsif cand_corr == best_corr
        best << candidate
      end
    end
    {
      best_corr_avg: best_corr / names_orderings_map.size.to_f,
      best: best
    }
  end

  def report(solution)
    puts "Best average correlation #{solution[:best_corr_avg]}"
    puts "Number of solutions with that score #{solution[:best].size}"
    solution[:best].each_with_index do |single_solution, i|
      puts "Solution \##{i+1}:"
      single_solution.each_with_index do |item, j|
        puts "#{j+1}. #{item}"
      end
    end
  end

  extend self
end
