# frozen_string_literal: true

#
# twitter_delete.rb
# Un-like tweets from a CSV file generated by `t` gem.
#
# Example:
#   $ t favourites -n 1000 --csv > likes.csv
#   $ ruby twitter_delete.rb likes.csv
#

require 'csv'
require 'pty'

CSV.foreach(ARGV[0]) do |row|
  next if row.nil? || row[0] == 'ID'

  puts "Processing tweet delete for tweet #{row[0]}:\n#{row[3]}"

  # Spawns a subprocess and outputs `y` for any input prompts
  PTY.spawn("t delete favorite #{row[0]}") do |_input, output, _pid|
    output.puts 'y'
    puts "\n  --> Processed...\n\n"
  end
end
