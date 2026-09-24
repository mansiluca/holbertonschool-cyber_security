#!/usr/bin/env ruby
require 'digest'

if ARGV.size != 2
  puts 'Usage: 10-password_cracked.rb HASHED_PASSWORD DICTIONARY_FILE'
  exit 1
end

target = ARGV[0]
dictionary = ARGV[1]

found = File.foreach(dictionary).map(&:chomp).find do |word|
  Digest::SHA256.hexdigest(word) == target
end

if found
  puts "Password found: #{found}"
else
  puts 'Password not found in dictionary.'
end
