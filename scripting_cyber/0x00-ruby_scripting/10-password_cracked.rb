#!/usr/bin/env ruby
require 'digest'

if ARGV.size != 2
  puts 'Usage: 10-password_cracked.rb HASHED_PASSWORD DICTIONARY_FILE'
  exit 1
end

hashed_password = ARGV[0].downcase
dictionary_file = ARGV[1]

found = false

File.foreach(dictionary_file) do |line|
  word = line.strip
  if Digest::SHA256.hexdigest(word) == hashed_password
    puts "Password found: #{word}"
    found = true
    break
  end
end

puts 'Password not found in dictionary.' unless found
