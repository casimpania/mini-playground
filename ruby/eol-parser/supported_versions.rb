#!/usr/bin/env ruby

#sw_name=ARGV[0]  ## Read cli parameter input

## include common config
require_relative './conf/common.conf.rb'

require 'json'
#json_file="https://endoflife.date/api/#{sw_name}.json"
json_file="./python.json"

raw_data=File.read(json_file)
parsed_data = JSON.parse(raw_data)

puts parsed_data['eol']
#puts parsed_data.keys

