#!/bin/bash
source shakedown.sh                             # load the framework

shakedown GET /about                            # make a GET request
  status 200                                    # assert response status is 200
  header 'Content-Type: text/html'              # assert response header exists
  contains 'Take back your privacy!'            # assert resposne body contains string

shakedown POST / -d 'q=Shakedown'               # make a POST request with form data
  status 200
  contains 'Bob Seger'

shakedown GET http://www.google.com -L          # provide full url to override default base url.
  status 200                                    # -L cURL option to follow redirects
