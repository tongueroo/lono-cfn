module LonoCfn
  class Create < Base
    # save_stack is the interface method
    def save_stack(params)
      create_stack(params)
    end

    # aws cloudformation create-stack --stack-name prod-hi-123456789 --parameters file://output/params/prod-hi-123456789.json --template-body file://output/prod-hi.json
    def create_stack(params)
      if stack_exists?
        puts "Cannot create a stack because the #{@stack_name} already exists."
        return
      end

      template_body = IO.read(@template_path)
      message = "#{@stack_name} stack creating."
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

    def stack_exists?
      return if @options[:noop]
      stack = cfn.describe_stacks(stack_name: @stack_name).stacks.first
      !!stack
    end
  end
end
