#!/usr/bin/env ruby

# register the dotfile here
# first will go find the file with the same directory
# second find the run file in the directory
# if there is no run file
#   copy directly
# else 
#   run run file 
#

require 'pry'
require 'pry-nav'

puts "Hello world"


dot_factory = {
  "gemrc"        => ".gemrc",
  "gitconfig"    => ".gitconfig",
  "slate"        => ".slate",
  "tmux.conf"    => ".tmux.conf",
  "vimrc"        => ".vimrc",
  "zshrc"        => ".zshrc"
}


def dotfile_path(file_name)
  Dir.home + "/#{file_name}"
end

def check_dotfile_exist?(file_name)
  File.exist? dotfile_path(file_name)
end

def backup_dotfile(file_name)
  FileUtils.cp(file_name, "#{file_name}.bak")
end

def check_in_correct_folder
  if File.exist?(Dir.pwd + "/install.rb")  
    puts "You're ready to go"
  else
    raise "Please go to your dotfile folder like 'cd ~/dotfiles' and try again"
  end
end

def link_file_to_dotfile(real_file, dest)
  FileUtils.ln_sf(real_file, dest)
end

check_in_correct_folder

dot_factory.each do |real_file, dotfile|

  if check_dotfile_exist?(dotfile)
    puts "#{dotfile} exist, backup it"
  end


  src = Dir.pwd + "/#{real_file}"
  dest = dotfile_path(dotfile)
  puts "Link #{src} to #{dest}"
  link_file_to_dotfile(src, dest)
end

