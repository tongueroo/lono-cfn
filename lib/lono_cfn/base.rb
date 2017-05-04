require "lono"
require "lono-params"

module LonoCfn
  class Base
    include AwsServices

    def initialize(stack_name, options={})
      @stack_name = stack_name
      @options = options
      @project_root = options[:project_root] || '.'

      template_name = options[:template] || @stack_name
      params_name = options[:params] || template_name
      @template_path = get_source_path(template_name, :template)
      @params_path = get_source_path(params_name, :params)
      puts "Using template: #{@template_path}"
      puts "Using parameters: #{@params_path}"
    end

    def run
      generate_templates if @options[:lono]
      check_for_errors
      params = generate_params
      save_stack(params) # defined in the sub class
    end

    def generate_templates
      Lono::DSL.new(
          project_root: @project_root,
          pretty: true
        ).run
    end

    def generate_params
      generator = LonoParams::Generator.new(@stack_name,
        project_root: @project_root,
        path: @params_path,
        allow_no_file: true)
      generator.generate  # Writes the json file in CamelCase keys format
      generator.params    # Returns Array in underscore keys format
    end

    def check_for_errors
      errors, warns = check_files
      unless errors.empty?
        puts "Please double check the command you ran.  There were some errors."
        puts "ERROR: #{errors.join("\n")}".colorize(:red)
        exit
      end
      unless errors.empty?
        puts "Please double check the command you ran.  There were some warnings."
        puts "WARN: #{errors.join("\n")}".colorize(:yellow)
      end
    end

    def check_files
      errors, warns = [], []
      unless File.exist?(@template_path)
        errors << "Template file missing: could not find #{@template_path}"
      end
      if @options[:params] && !File.exist?(@params_path)
        warns << "Parameters file missing: could not find #{@params_path}"
      end
      [errors, warns]
    end

    def stack_exists?
      return true if testing_update?
      return false if @options[:noop]

      exist = true
      begin
        # When the stack does not exist an exception is raised. Example:
        # Aws::CloudFormation::Errors::ValidationError: Stack with id blah does not exist
        response = cfn.describe_stacks(stack_name: @stack_name)
      rescue Aws::CloudFormation::Errors::ValidationError => e
        e.message
        if e.message =~ /Stack with/ || e.message =~ /does not exist/
          exist = false
        end
      end
      exist
    end

    # if existing in params path then use that
    # if it doesnt assume it is a full path and check that
    # else fall back to convention, which also eventually gets checked in check_for_errors
    #
    # Type - :params or :template
    def get_source_path(path, type)
      default_convention_path = convention_path(@stack_name, type)

      return default_convention_path if path.nil?
      # convention path based on the input from the user
      convention_path(path, type)
    end

    def convention_path(name, type)
      case type
      when :template
        format = detect_format
        "#{@project_root}/output/#{name}.#{format}"
      when :params
        "#{@project_root}/params/#{name}.txt"
      else
        raise "hell: dont come here"
      end
    end

    # Returns String with value of "yml" or "json".
    def detect_format
      formats = Dir.glob("#{@project_root}/output/**/*").map { |path| path }.
                  reject { |s| s =~ %r{/params/} }. # reject output/params folder
                  map { |path| File.extname(path) }.
                  reject { |s| s.empty? }. # reject ""
                  uniq
      if formats.size > 1
        puts "ERROR: Detected multiple formats: #{formats.join(", ")}".colorize(:red)
        puts "All the output files must use the same format.  Either all json or all yml."
        exit 1
      else
        formats.first.sub(/^\./,'')
      end
    end

    def testing_update?
      ENV['TEST'] && self.class.name == "LonoCfn::Update"
    end
  end
end
