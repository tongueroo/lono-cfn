module LonoCfn
  class CLI < Thor
    class Help
      class << self
        def create
<<-EOL
Example:

Create a stack name `my-stack` using the output/my-stack.json CloudFormation template and `params/my-stack.text` files.

The `params/my-stack.txt` simple format also converted and gets written params/output/my-stack.json in case you want to use it as a part of the raw `aws cloudformation create-stack` command for deubgging.

$ lono-cfn create my-stack

$ lono-cfn create my-stack --template different-template-path

$ lono-cfn create my-stack --params different-params-path

EOL
        end
      end
    end
  end
end
