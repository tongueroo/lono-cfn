module LonoCfn
  class Update < Base
    # save_stack is the interface method
    def save_stack(params)
      update_stack(params)
    end

    # aws cloudformation update-stack --stack-name prod-hi-123456789 --parameters file://output/params/prod-hi-123456789.json --template-body file://output/prod-hi.json
    def update_stack(params)
      unless stack_exists?(@stack_name)
        puts "Cannot update a stack because the #{@stack_name} does not exists."
        return
      end
      exist_unless_updatable(stack_status(@stack_name))

      message = "Updating #{@stack_name} stack"
      error = nil
      if @options[:noop]
        message = "NOOP #{message}"
      else
        preview_changes if @options[:preview]
        are_you_sure?

        if @options[:change_set] # defaults to this
          message << " via change set: #{plan.change_set_name}"
          change_set_update
        else
          standard_update(params)
        end
      end
      puts message unless @options[:mute] || error
    end

    def standard_update(params)
      template_body = IO.read(@template_path)
      begin
        cfn.update_stack(
          stack_name: @stack_name,
          template_body: template_body,
          parameters: params#,
          # capabilities: ["CAPABILITY_IAM"]
        )
      rescue Aws::CloudFormation::Errors::ValidationError => e
        puts "ERROR: #{e.message}".red
        error = true
      end
    end

    def plan
      return @plan if @plan
      @plan = Plan.new(@stack_name, @options.merge(lono: false, mute_params: true))
      @plan.setup
      @plan
    end

    def preview_changes
      plan.preview_change_set
    end

    def change_set_update
      plan.execute_change_set
    end

    def are_you_sure?
      if @options[:sure]
        sure = 'y'
      else
        puts "Are you sure you want to want to update the stack with the changes? (y/N)"
        sure = $stdin.gets
      end

      unless sure =~ /^y/
        puts "Exiting without updating"
        exit 0
      end
    end
  end
end
