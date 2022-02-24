require 'json'
require 'date'

file = File.read('./python.json')
data_hash = JSON.parse(file)

## NOTE: To dump all the values
#~data_hash.each { |i| puts "#{i}" }
#~exit

year=DateTime.now.year.to_s
month=DateTime.now.month.to_s
day=DateTime.now.day.to_s
date_now="#{year}-#{month}-#{day}"

data_hash.each { 
    |each_entry|
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
}
