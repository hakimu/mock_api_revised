#!/usr/bin/env ruby
require_relative './lib/mock_client'
require_relative 'input_org'
require 'optparse'

options = {}

parser = OptionParser.new do |opts|

  opts.banner = "Usage: api client [options]"

  opts.on('-o', '--organization=organization','Organization number to be pulled from the API') do |organization|
    options[:organization] = organization
  end

  opts.on('-c', '--child=child', Array, 'Child accounts to be pulled from the API') do |child|
    options[:child] = child
  end

  opts.on('-h', '--help', 'Display') do
    puts opts
    exit
  end

end.parse!

raise OptionParser::MissingArgument.new("Searching by organization (-o, --organization=organization) is mandatory") if options[:organization].nil?

# puts options
org = options[:organization].to_i
# Need to fix for only passing in one child argument
# child_1, child_2 = options[:child].map(&:to_i)

if options[:child] == nil
  io = InputOrg.new(org)
  io.create_org
  puts io.flatten
  data = io.inspect.to_json
  io.write_datastructure_to_file(data)
elsif options[:child].count == 1
  child = options[:child].join
  io = InputOrg.new(org, child)
  io.create_org
  io.create_children
  puts io.flatten
  data = io.inspect.to_json
  io.write_datastructure_to_file(data)
else
  *child = options[:child].map(&:to_i)
  io = InputOrg.new(org, *child)
  io.create_org
  io.create_children
  puts io.flatten
  data = io.inspect.to_json
  io.write_datastructure_to_file(data)
end


