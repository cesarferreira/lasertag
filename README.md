# Lasertag
[![Gem Version](https://badge.fury.io/rb/lasertag.svg)](https://badge.fury.io/rb/lasertag) [![Build Status](https://travis-ci.org/cesarferreira/lasertag.svg?branch=master)](https://travis-ci.org/cesarferreira/lasertag)  [![security](https://hakiri.io/github/cesarferreira/lasertag/master.svg)](https://hakiri.io/github/cesarferreira/lasertag/master) [![Code Climate](https://codeclimate.com/github/cesarferreira/lasertag/badges/gpa.svg)](https://codeclimate.com/github/cesarferreira/lasertag) [![Inline docs](http://inch-ci.org/github/cesarferreira/lasertag.svg?branch=master)](http://inch-ci.org/github/cesarferreira/lasertag)

> Like most VCSs, Git has the ability to tag specific points in history as being important. Typically people use this functionality to mark release points (v1.0.0, and so on)

<!-- Match your CVS tags with your android versions with laser speed! -->

*[INSERT GIF HERE]*


## Basic Usage

    $ lasertag --module [module_name]

#### Going deeper

If you want to specify a flavor:

    $ lasertag --module app --flavor prod


## Installation

    $ gem install lasertag

## Under the hood

- Tries to compile the project
- Find out the package and the app version
- executes git tag -a v[tag_version] -m "tag [tag_name]"
- executes git push origin
- executes git push origin [tag_name]


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

