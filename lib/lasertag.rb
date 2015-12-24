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
      @app_module = nil
      @app_flavor = nil

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

        opts.on('-f', '--flavor FLAVOR', 'Specifies the flavor (e.g. dev, qa, prod)') do |app_flavor|
          @app_flavor = app_flavor
        end

        opts.on('-m', '--module MODULE', 'Specifies the app module') do |app_module|
          @app_module = app_module
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

      # if @clear_flag
      #   android_project.clear_app_data
      # end

      unless @app_module
        puts "Please give me an app module name".yellow
        exit 1
      end

      handle_it_all

    end

    def handle_it_all

      Dir.chdir @app_path

      ### Assemble
      is_success = system assemble_command

      unless is_success
        puts "\n\nSomething went wrong so I stopped all the madness!!\n".red
        exit 1
      end

      ### Get project properties
      @hash = project_properties @app_module

      puts "\n"

      ### Find app info
      app_info = get_app_info

      puts "For package #{app_info[:package].yellow}\n"

      ### dont let uncommited stuffgit commit


      ### git tag -a "versionNumber" -m "versionName"

      package = app_info[:package]
      name = @app_module # not quite correct
      version = app_info[:versionName]


      builded = "#{@app_module}/build/outputs/apk/#{@app_module}-#{@app_flavor}-release-unsigned.apk"

      puts "#{name} #{version} built to #{builded}.".green

      tag = "git tag -a v#{version} -m 'versionCode: #{app_info[:versionCode]}'"

      puts "Tagged v#{version}.".green
      puts "Pushed git commits and tags.".green
      puts "Pushed #{name} #{version} to remote.".green

      ### git push --tags

      # lasertag 0.2.1 built to pkg/lasertag-0.2.1.gem.
      # Tagged v0.2.1.
      # Pushed git commits and tags.
      # Pushed lasertag 0.2.1 to rubygems.org.
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

    #########################################################

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

      flavor = @app_flavor ? "/#{@app_flavor}/" : "/"

      path = "#{build_dir}/intermediates/manifests/full"
      path = "#{path}#{flavor}release/"

      full_path = File.join(path, 'AndroidManifest.xml')

      exists = File.exist?(full_path)

      unless exists
        puts "#{full_path.gsub(build_dir,'').yellow} could not be found"
        puts "   Try specifying a Flavor".green
        exit 1
      end


      full_path
    end

    def assemble_command
      "gradle :#{@app_module}:assemble#{(@app_flavor or "").capitalize}Release"
    end

  end
end
