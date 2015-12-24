require 'optparse'
require 'colorize'
require 'lasertag/version'
# require 'pry'

module Lasertag
  class MainApp
    def initialize(arguments)

      # defaults
      @app_path = Dir.pwd
      @module = nil
      @flavour = nil

      @require_analyses = true

      # Parse Options
      create_options_parser(arguments)

      manage_opts

    end

    def create_options_parser(args)

      args.options do |opts|
        opts.banner = "Usage: lasertag [OPTIONS]"
        opts.separator  ''
        opts.separator  "Options"

        opts.on('-p PATH', '--path PATH', 'Custom path to android project') do |app_path|
          @app_path = app_path if @app_path != '.'
        end

        opts.on('-f', '--flavour FLAVOUR', 'Specifies the flavour (e.g. dev, qa, prod)') do |flavour|
          @flavour = flavour
        end

        opts.on('-h', '--help', 'Displays help') do
          @require_analyses = false
          puts opts.help
          exit
        end
        opts.on('-v', '--version', 'Displays version') do
          @require_analyses = false
          puts Lasertag::VERSION
          exit
        end
        opts.parse!

      end
    end

    ##
    ## Manage options
    ##
    def manage_opts

      if @require_analyses
        # instatiate android project
        # android_project = AndroidProject.new(@app_path)

        # # is a valid android project?
        # unless android_project.is_valid
        #   puts "#{@app_path.red} is not a valid android project"
        #   exit
        # end
      end

      if @clear_flag
        android_project.clear_app_data
      end

    end

    def android_home_is_defined
      sdk = `echo $ANDROID_HOME`.gsub("\n",'')
      !sdk.empty?
    end

    def call
      unless android_home_is_defined
        puts "\nWARNING: your #{'$ANDROID_HOME'.yellow} is not defined\n"
        puts "\nhint: in your #{'~/.bashrc'.yellow} add:\n  #{"export ANDROID_HOME=\"/Users/cesarferreira/Library/Android/sdk/\"".yellow}"
        puts "\nNow type #{'source ~/.bashrc'.yellow}\n\n"
        exit 1
      end
    end

    def settings_gradle_file(path = @base_path)
      File.join(path, 'settings.gradle')
    end

    def is_valid(settings_path = @settings_gradle_path)
      File.exist?(settings_path)
    end

  end
end
