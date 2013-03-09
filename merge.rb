#!/usr/bin/env ruby
# Bring OptionParser into the namespace
require 'optparse'

@options = {}

def handle_file( filename )
  file = File.open( filename, "rb" )
  file.each do |line|
    if @options[:snip] && line =~ /<!-- SNIP -->/.. line =~/<!-- \/SNIP -->/
       next
    elsif /^<<\[([^\]]+)\]$/ =~ line
       handle_file( $1 )
    else
       puts line
    end
  end
end


option_parser = OptionParser.new do |opts|
  # Create a switch
  opts.on("-s","--snip") do 
    @options[:snip] = true
  end
end
option_parser.parse!

unless ARGV.length > 0
  puts "Usage: merge.rb <index_filename>" 
  exit
end

for f in ARGV do
   handle_file( f )
end
