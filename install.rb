#!/usr/bin/env ruby

require 'fileutils'

dot_factory = {
  "gemrc"        => ".gemrc",
  "gitconfig"    => ".gitconfig",
  "slate"        => ".slate",
  "tmux.conf"    => ".tmux.conf",
  "vimrc"        => ".vimrc",
  "zshrc"        => ".zshrc",
  "gitignore"    => ".gitignore"
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

def link_file_to_dotfile(src, dest)
  FileUtils.ln_sf(src, dest)
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

