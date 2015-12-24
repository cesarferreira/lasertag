require 'optparse'
require 'colorize'
require 'hirb'
require 'oga'
require 'lasertag/version'
require 'pry'

module Lasertag
  class MainApp
    def initialize(arguments)

      # defaults
      @app_path = Dir.pwd
      @module = nil
      @flavour = nil

      @require_analyses = true

      # Parse Options
      arguments.push "-h" if arguments.length == 0
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

##############


    def convert_values_to_hash (str)
      hash = Hash.new

      str.split(/\r?\n|\r/).each { |line|
        next unless line.include? ':'
        indexOf = line.index(':')
        next unless indexOf > 0

        key = line[0..indexOf-1].strip
        value = line[indexOf+1..line.length].strip

        hash[key] = value
      }

      hash
    end

    def project_properties(project=nil)

      project = "#{project}:" if project

      result = %x[gradle #{project}properties]
      hash = convert_values_to_hash result
      #puts Hirb::Helpers::AutoTable.render(hash)
      hash
    end


    def get_app_info
      path = get_path_to_merged_manifest
      handle = File.open(path)

      parser = Oga.parse_xml(handle)

      #  package="com.cesarferreira.testout"
      #  versionCode="10000"
      #  versionName="1.0.0"
      package     = parser.xpath("//manifest").attr('package').last.value
      versionCode = parser.xpath("//manifest").attr('android:versionCode').last.value
      versionName = parser.xpath("//manifest").attr('android:versionName').last.value

      {
        package: package,
        versionCode: versionCode,
        versionName: versionName,
      }
    end

    def get_path_to_merged_manifest
      build_dir = @hash['buildDir']

      flavor = @flavor ? "/#{@flavor}/" : "/"

      full_path = "#{build_dir}/intermediates/manifests/full#{flavor}release/AndroidManifest.xml"
      full_path
    end

    def assemble_command
      "gradle assemble#{(@flavor or "").capitalize}Release"
    end


  end
end
