#!/usr/bin/env ruby
require 'open-uri'
require 'uri'
require 'fileutils'

if ARGV.size != 2
  puts "Usage: #{File.basename($PROGRAM_NAME)} URL LOCAL_FILE_PATH"
  exit
end

url = ARGV[0]
local_path = ARGV[1]

puts "Downloading file from #{url}..."
FileUtils.mkdir_p(File.dirname(local_path))
URI.open(url) { |file| File.binwrite(local_path, file.read) }
puts "File downloaded and saved to #{local_path}."
