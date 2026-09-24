#!/usr/bin/env ruby
require 'json'

def merge_json_files(file1_path, file2_path)
  data1 = JSON.parse(File.read(file1_path))
  data2 = JSON.parse(File.read(file2_path))
  File.write(file2_path, JSON.pretty_generate(data2 + data1))
end
