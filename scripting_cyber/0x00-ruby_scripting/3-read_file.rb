#!/usr/bin/env ruby
require 'json'

def count_user_ids(path)
  users = JSON.parse(File.read(path))
  counts = Hash.new(0)
  users.each { |user| counts[user['userId']] += 1 }
  counts.sort_by { |id, _| id.to_i }.each { |id, count| puts "#{id}: #{count}" }
end
