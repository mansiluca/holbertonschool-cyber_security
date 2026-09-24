#!/usr/bin/env ruby
require 'optparse'

TASKS_FILE = 'tasks.txt'

def load_tasks
  File.exist?(TASKS_FILE) ? File.readlines(TASKS_FILE, chomp: true) : []
end

def save_tasks(tasks)
  File.write(TASKS_FILE, tasks.map { |task| "#{task}\n" }.join)
end

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: cli.rb [options]'
  opts.on('-a', '--add TASK', 'Add a new task') { |task| options[:add] = task }
  opts.on('-l', '--list', 'List all tasks') { options[:list] = true }
  opts.on('-r', '--remove INDEX', Integer, 'Remove a task by index') do |index|
    options[:remove] = index
  end
  opts.on('-h', '--help', 'Show help') do
    puts opts
    exit
  end
end.parse!

tasks = load_tasks

if options[:add]
  tasks << options[:add]
  save_tasks(tasks)
  puts "Task '#{options[:add]}' added."
end

if options[:remove]
  task = tasks.delete_at(options[:remove] - 1)
  save_tasks(tasks)
  puts "Task '#{task}' removed." if task
end

if options[:list]
  puts 'Tasks:'
  tasks.each_with_index { |task, index| puts "#{index + 1}. #{task}" }
end
