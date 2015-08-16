#!/bin/bash
source shakedown.sh                             # load the framework

shakedown GET /foo                              # make a GET request
  status 404                                    # assert on http status code
  header 'Content-Type: text/html'              # assert on response header
  contains 'Not found'                          # assert body contains string
  matches 'No.*'                                # assert body matches regex

shakedown HEAD /                                # make a HEAD request
  status 302

shakedown GET / -H 'Accept: application/json'   # add curl options
  print_headers                                 # output response headers for debugging
  print_body                                    # output response body for debugging
  status 200
  header 'Content-Type: application/json'

shakedown PUT /user/1 -d name=Rob               # make a PUT request
  status 201
