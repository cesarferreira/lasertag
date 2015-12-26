# Lasertag
[![Gem Version](https://badge.fury.io/rb/lasertag.svg)](https://badge.fury.io/rb/lasertag) [![Build Status](https://travis-ci.org/cesarferreira/lasertag.svg?branch=master)](https://travis-ci.org/cesarferreira/lasertag)  [![security](https://hakiri.io/github/cesarferreira/lasertag/master.svg)](https://hakiri.io/github/cesarferreira/lasertag/master) [![Code Climate](https://codeclimate.com/github/cesarferreira/lasertag/badges/gpa.svg)](https://codeclimate.com/github/cesarferreira/lasertag) [![Inline docs](http://inch-ci.org/github/cesarferreira/lasertag.svg?branch=master)](http://inch-ci.org/github/cesarferreira/lasertag)

> Like most VCSs, Git has the ability to tag specific points in history as being important. Typically people use this functionality to mark release points (v1.0.0, and so on)

<!-- Match your CVS tags with your android versions with laser speed! -->

<p align="center">
<img src="extras/terminal.gif" />
</p>


## Basic Usage

    $ lasertag --module [module_name]

This will extract the android's app module `version` and create a matching `git tag`.
Pretty helpful in situations like my personal choice of git workflow, the [Gitflow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow), a strict branching model designed around the project release:

<p align="center">
<img src="extras/gitflow.png" />
</p>

#### Help

    Usage: lasertag [OPTIONS]

    Options
      -m, --module MODULE    # Specifies the app module
      -f, --flavor FLAVOR    # Specifies the flavor (e.g. dev, qa, prod)
      -p, --path PATH        # Custom path to android project
      -r, --remote REMOTE    # Custom remote to your project (default: "origin")
      -h, --help             # Displays help
      -v, --version          # Displays version


## Installation

    $ gem install lasertag

## Under the hood

- Tries to compile the project
- Find out the package and the app version
- executes git tag -a v[tag_version] -m "tag [tag_name]"
- executes git push origin [tag_name]

when a step fails, it stops the whole process.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

