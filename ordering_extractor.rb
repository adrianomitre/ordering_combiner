require 'csv'
require 'set'

def get_ordering_for_name(csv, name)
  group_members = csv[1].compact.to_set
  raise unless group_members.include?(name)
  name_index = csv[1].index(name)
  pos_col = csv[2].index { |col| col =~ /^Pos/ }
  proj_ranking =
    3.upto(3+10-1).map do |i|
      csv[i].values_at(0, name_index)
    end
  proj_ranking.sort_by { |pr| pr[-1].to_i }.map { |pr| pr[0].to_sym }
end

def extract_orderings_from_csv(filename)
  csv = CSV.read(filename)
  group_members = csv[1].compact
  group_members.map do |member_name|
    [member_name.to_sym, get_ordering_for_name(csv, member_name)]
  end.to_h
end
