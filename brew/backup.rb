require 'pry'
require 'pry-nav'

lists = `brew list`.split("\n")

File.open("./brews", "w+") do |file|
  lists.each do |list|
    file << list
    file << "\n"
  end
end

