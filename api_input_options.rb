#!/usr/bin/env ruby
require_relative './lib/mock_client'
require_relative 'input_org.rb'
require 'optparse'

options = {}

parser = OptionParser.new do |opts|

  opts.banner = "Usage: api client [options]"

  opts.on('-o', '--organization=organization','Organization number to be pulled from the API') do |organization|
    options[:organization] = organization
  end

  opts.on('-c', '--child=child', Array, 'Child accounts to be pulled from the API') do |child|
    # child.map{|i| i.to_i }
    puts "child is #{child} of class #{child.class}"
    # options[:child] = child
    options[:child] = child
    puts "child is #{child} of class #{child.class}"
  end

  opts.on('-h', '--help', 'Display') do
    puts opts
    exit
  end

end.parse!

raise OptionParser::MissingArgument.new("Searching by organization (-o, --organization=organization) is mandatory") if options[:organization].nil?

