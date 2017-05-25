module LonoCfn
  class Delete
    include AwsServices

    def initialize(stack_name, options={})
      @stack_name = stack_name
      @options = options
      @project_root = options[:project_root] || '.'
    end

    def run
      message = "Deleted #{@stack_name}."
      if @options[:noop]
        puts "NOOP #{message}"
      else
        if stack_exist?
          cfn.delete_stack(stack_name: @stack_name)
          puts message
        else
          puts "#{@stack_name.inspect} stack does not exist".colorize(:red)
        end
      end
    end

    def stack_exist?
      begin
        cfn.describe_stacks(stack_name: @stack_name)
        true
      rescue Aws::CloudFormation::Errors::ValidationError
        false
      end
    end
  end
end
