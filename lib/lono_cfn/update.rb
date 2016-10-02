module LonoCfn
  class Update < Base
    # save_stack is the interface method
    def save_stack(params)
      update_stack(params)
    end

    # aws cloudformation update-stack --stack-name prod-hi-123456789 --parameters file://output/params/prod-hi-123456789.json --template-body file://output/prod-hi.json
    def update_stack(params)
      template_body = IO.read(@template_path)
      message = "#{@stack_name} stack updating."
      if @options[:noop]
        message = "NOOP #{message}"
      else
        cfn.update_stack(
          stack_name: @stack_name,
          template_body: template_body,
          parameters: params#,
          # capabilities: ["CAPABILITY_IAM"]
        )
      end
      puts message unless @options[:mute]
    end
  end
end