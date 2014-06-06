require 'pry'
require 'pry-nav'

File.open("./brews", "r+") do |file|
  file.each do |line|
    puts line
  end
end

