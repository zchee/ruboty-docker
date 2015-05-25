[![Build Status](https://travis-ci.org/zchee/ruboty-docker.svg?branch=master)](https://travis-ci.org/zchee/ruboty-docker)
[![Circle CI](https://circleci.com/gh/zchee/ruboty-docker.svg?style=svg)](https://circleci.com/gh/zchee/ruboty-docker)  
[![Coverage Status](https://coveralls.io/repos/zchee/ruboty-docker/badge.svg)](https://coveralls.io/r/zchee/ruboty-docker)
[![Code Climate](https://codeclimate.com/github/zchee/ruboty-docker/badges/gpa.svg)](https://codeclimate.com/github/zchee/ruboty-docker)
[![Test Coverage](https://codeclimate.com/github/zchee/ruboty-docker/badges/coverage.svg)](https://codeclimate.com/github/zchee/ruboty-docker/coverage)  
[![Dependency Status](https://gemnasium.com/zchee/ruboty-docker.svg)](https://gemnasium.com/zchee/ruboty-docker)
# Ruboty::Docker

Management Docker via Ruboty ChatOps.  

This plugin is **Experimental!**  
I wrote ruby gem this is the first time.   
This Gem is learning ruby for me.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-docker'
```

And then execute:

    $ bundle

And, launch ruboty:

```
$ docker run -v /var/run/docker.sock:/var/run/docker.sock your/rubotyimage
```

#### Tips
This plugin recommend to Ruboty on Docker container.  
and, set
   
    -v /var/run/docker.sock:/var/run/docker.sock
   
That way, `DOCKER_HOST` environment is set automatically `unix:///var/run/docker.sock`.  

If do not use Docker container, please set Docker IP on `RUBOTY_DOCKER_HOST` environment.  
and, set `RUBOTY_DOCKER_CERT_PATH`.

e.g.
```
RUBOTY_DOCKER_HOST=tcp://192.168.252.141:2376
RUBOTY_DOCKER_CERT_PATH=/Users/zchee/.docker/machine/machines/vmware-system
```

## Usage
```
@ruboty docker run ....
@ruboty docker images
@ruboty docker ps
and more...
```

## Contributing

1. Fork it ( https://github.com/zchee/ruboty-docker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
