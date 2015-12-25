# Lasertag
[![Gem Version](https://badge.fury.io/rb/lasertag.svg)](https://badge.fury.io/rb/lasertag) [![Build Status](https://travis-ci.org/cesarferreira/lasertag.svg?branch=master)](https://travis-ci.org/cesarferreira/lasertag)  [![security](https://hakiri.io/github/cesarferreira/lasertag/master.svg)](https://hakiri.io/github/cesarferreira/lasertag/master) [![Code Climate](https://codeclimate.com/github/cesarferreira/lasertag/badges/gpa.svg)](https://codeclimate.com/github/cesarferreira/lasertag) [![Inline docs](http://inch-ci.org/github/cesarferreira/lasertag.svg?branch=master)](http://inch-ci.org/github/cesarferreira/lasertag)

> Match your CVS tags with the android versions with laser speed!

*[INSERT GIF HERE]*


## Basic Usage

    $ lasertag --module [module_name]

#### Going deeper

If you want to specify a flavor:

    $ lasertag --module app --flavor prod

## Under the hood

- Tries to compile the project
- Find out the package and the app version
- executes git tag -a v[tag_version] -m "tag [tag_name]"
- executes git push origin
- executes git push origin [tag_name]


## Installation

    $ gem install lasertag

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

