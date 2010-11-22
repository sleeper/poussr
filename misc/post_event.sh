#!/bin/bash

# $1 : channel's name
# $2: event name
# $3 : payload

# post_event.sh mychannel newm "{'title': 'foo'}"
#  ==  curl -X 'POST' -d "{'title': 'foo'}" http://127.0.0.1:3000/v1/channels/mychannel/events?name=newm

curl -X 'POST' -d "$3" http://127.0.0.1:3000/v1/channels/$1/events?name=$2
