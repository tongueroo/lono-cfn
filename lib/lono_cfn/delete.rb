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
        message = "NOOP #{message}"
      else
        cfn.delete_stack(stack_name: @stack_name)
      end
      puts message
    end
  end
end
