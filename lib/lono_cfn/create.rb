# hack require until I gemify lono-params
puts "REMEMBER TO PACKAGE LONO-PARAMS AS GEM"
require "lono"
require "aws-sdk"

module LonoCfn
  class Create
    def initialize(stack_name, options={})
      @stack_name = stack_name
      @options = options
      @project_root = options[:project_root] || '.'
      @template_path = get_source_path(options[:template], :template)
      @params_path = get_source_path(options[:params], :params)
      @region = options[:region] || 'us-east-1'
    end

    def run
      check_for_errors
      generate_templates if @options[:lono]
      params = generate_params
      puts "Using template: #{@template_path}"
      puts "Using parameters: #{@params_path}"
      create_stack(params)
    end

    def generate_params
      generator = LonoParams::Generator.new(@stack_name,
        project_root: @project_root,
        path: @params_path)
      generator.generate  # Writes the json file in CamelCase keys format
      generator.params    # Returns Array in underscore keys format
    end

    def generate_templates
      Lono::DSL.new(
          project_root: @project_root,
          pretty: true
        ).run
    end

    # aws cloudformation create-stack --stack-name cluster-hi \
    #   --template-body file://output/cluster-hi.json \
    #   --parameters file://parameters/output/cluster-hi.json
    def create_stack(params)
      template_body = IO.read(@template_path)
      message = "#{@stack_name} stack created."
      if @options[:noop]
        message = "NOOP #{message}"
      else
        cfn.create_stack(
          stack_name: @stack_name,
          template_body: template_body,
          parameters: params#,
          # capabilities: ["CAPABILITY_IAM"]
        )
      end
      puts message unless @options[:mute]
    end

    def cfn
      @cfn ||= Aws::CloudFormation::Client.new(region: @region)
    end

    def check_for_errors
      errors = check_files
      unless errors.empty?
        puts "Please double check the command you ran.  There were some errors."
        puts "#{errors.join("\n")}" 
        exit
      end
    end

    def check_files
      errors = []
      unless File.exist?(@template_path)
        errors << "Template file missing: could not find output/#{@template_path}.json"
      end
      unless File.exist?(@params_path)
        errors << "Parameters file missing: could not find params/#{@params_path}.txt"
      end
      errors
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
      convention_path = convention_path(path, type)
      File.exist?(convention_path) ? convention_path : path
    end

    def convention_path(name, type)
      case type
      when :template
        "#{@project_root}/output/#{name}.json"
      when :params
        "#{@project_root}/params/#{name}.txt"
      else
        raise "hell: dont come here"
      end
    end
  end
end
