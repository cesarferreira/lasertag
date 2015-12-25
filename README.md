# Lasertag
[![Build Status](https://travis-ci.org/cesarferreira/lasertag.svg?branch=master)](https://travis-ci.org/cesarferreira/lasertag) [![Gem Version](https://badge.fury.io/rb/lasertag.svg)](https://badge.fury.io/rb/lasertag)

> Match your CVS tags with the android versions in laser speed!

*[INSERT GIF HERE]*


## Basic Usage

    $ lasertag --module [module_name]

#### Going deeper

If you want to specify a flavor:

    $ lasertag --module app --flavor prod

## What happens?

- Tries to compile the project
- Find out the pacakge and the version
- executes git tag -a v[tag_version] -m "tag [tag_name]"
- executes git push origin
- executes git push origin [tag_name]


## Installation

    $ gem install lasertag

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

