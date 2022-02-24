#!/usr/bin/env python3

## ADAPTED FROM https://www.geeksforgeeks.org/how-to-read-a-json-response-from-a-link-in-python/
## and hints from https://www.programiz.com/python-programming/datetime/current-datetime

## TODO:
##  * Sync implementation with php

import sys
import json

from urllib.request import urlopen
from datetime import date

# Read software name from CLI argument
sw_name=str(sys.argv[1])

# store the URL in url as
# parameter for urlopen
url="https://endoflife.date/api/" + sw_name + ".json"

# store the response of URL
response = urlopen(url)

# storing the JSON response
# from url in data
data_json = json.loads(response.read())

# print relevant data
#  * only show those that are not EOL
#
date_today = date.today().strftime("%Y-%m-%d")
for each_entry in data_json:
    if each_entry['eol'] > date_today:
        print (each_entry)
