#!/bin/bash
source $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/shakedown.sh      # load the framework

shakedown GET /about                            # make a GET request
  status 200                                    # assert response status is 200
  content_type 'text/html'                      # assert content type contains string
  header 'Expires'                              # assert response header exists containing string
  contains 'Take back your privacy!'            # assert resposne body contains string

shakedown POST / -d 'q=Shakedown'               # make a POST request with form data
  status 200
  contains 'Bob Seger'

shakedown GET http://www.google.com -L          # provide full url to override default base url.
  status 200                                    # -L cURL option to follow redirects
