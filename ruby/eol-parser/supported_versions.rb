#!/usr/bin/env ruby

### Made mainly with the help of the following:
###  * https://jhawthorn.github.io/curl-to-ruby/
###  * https://gist.github.com/timsavery/1657351

sw_name=ARGV[0]  ## Read cli parameter input

## include common config
##
## TODO:
##   * Use these config
##   * use same algorithm as the php version
require_relative './conf/common.conf.rb'

require "json"
require "net/http"
require "uri"
require "date"
json_url="https://endoflife.date/api/#{sw_name}.json"

uri = URI.parse(json_url)
response = Net::HTTP.get_response(uri)

year=DateTime.now.year.to_s
month=DateTime.now.month.to_s
day=DateTime.now.day.to_s
date_now="#{year}-#{month}-#{day}"

if response.code == "200"
  result = JSON.parse(response.body)

  result.each do |each_entry|
    if each_entry.fetch("eol") > date_now
        each_entry.each {
            |k,v|
            puts "#{k} = #{v}"
        }
    else
        next ## skip those without "eol"
    end
    ## Put separator for next group...
    10.times { print '-' }
    print "\n"
  end
else
  puts "ERROR!!!"
end
