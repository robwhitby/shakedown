# shakedown

A tiny Bash DSL for HTTP testing.

Make HTTP requests and assert on the response body and headers.


## DSL
```
shakedown <VERB> <PATH> <CURL OPTIONS>
  <assertion>
  <assertion>
  ...
```

## Example

Create `test.sh`:
```bash
#!/bin/bash
source shakedown.sh

shakedown GET /about
  status 200
  header 'Content-Type: text/html'
  contains 'Take back your privacy!'

shakedown POST / -d 'q=Shakedown'
  status 200
  contains 'Bob Seger'
```

Run the tests against a base URL:
```
$ bash test.sh -u https://duckduckgo.com
Starting shakedown of https://duckduckgo.com

GET /about
 ✔ status 200
 ✔ header Content-Type: text/html
 ✔ contains "Take back your privacy!"

POST /
 ✔ status 200
 ✔ contains "Bob Seger"

Shakedown complete. 2 passed, 0 failed.
```

## Assertions

```
status 'response status code'
contains 'string in response body'
matches 'regex in response body'
header 'string in response headers'
```


## HTTP Authentication

Use the -c option to provide credentials.

```bash test.sh -u my.domain.com -c user:pass```


## Setting cURL options

Any parameters after the path are passed straight on to cURL.

e.g. To send form data, follow redirects and set verbose output.

```shakedown POST /search -d 'query=shakedown' -L -v```


## Exit code

The exit code is set to the number of failed tests.


## Debugging

To help diagnose failing tests use ```print_headers```, ```print_body```, or make cURL verbose with '-v'.

## More Examples

```bash
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
```
