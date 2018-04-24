require_relative './lib/mock_client'
require_relative './lib/account'
require_relative './lib/organization'
require 'json'

class InputOrg

  attr_accessor :org, :child

  def initialize(org_id, *children)
    @org_id = org_id.to_i
    @children = children
  end

  def create(id)
    retries ||= 0
    org_data = JSON.parse(MockClient.new("http://localhost:9292").org(id))
    accounts = JSON.parse(MockClient.new("http://localhost:9292").accounts_by_org_id(id))
    users = JSON.parse(MockClient.new("http://localhost:9292").users_by_org(id))
    Organization.new(org_data["id"],org_data["name"],org_data["parent_id"],org_data["type"], accounts, users)
    
    # retry in the event of a parsing problem due to a random 'service unavailable'
    rescue JSON::ParserError
      retry if (retries += 1) <= 5
  end

  def create_org
    self.org = create(@org_id)
  end

  def create_children
    self.child = @children.map do |child|
      create(child)
    end
  end

  def flatten
    puts "==self child is #{self.child.nil?}=="
    if check_whether_child_is_subsidiary.all?
      format_org_with_subsidiary
    else
      format_org
    end
  end

  def write_datastructure_to_file(input)
    data = input
    File.open("datastructure.txt","a") do |f|
      f.puts "\r" + data
    end
  end

  private

  def format_org
    "#{org.name}: accounts#{org.accounts} support score- #{org.calculate_support_score} users:#{org.users}"
  end

  def format_org_with_subsidiary
    <<-STR
#{org.name} accounts#{org.accounts} support score- #{org.calculate_support_score} users#{org.users}
#{format_output_child_org} 
    STR
  end

  def format_output_child_org
    child.map {|c| "#{c.name} accounts#{c.accounts} users#{c.users}"}.join("\n")
  end

  def check_whether_child_is_subsidiary
    self.child.map {|c| c.type == "subsidiary" ? true : false } unless self.child.nil? || false
  end

end

# io = InputOrg.new(4,26,37)
# io.create_org
# io.create_children
# puts io.flatten
# data = io.inspect.to_json
# File.open("datastructure.txt","a") do |f|
#   f.puts "\r" + data
# end
