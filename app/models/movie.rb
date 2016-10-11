class Movie < ActiveRecord::Base
  require 'sort_by_rank.rb'
  include SortByRank
end
