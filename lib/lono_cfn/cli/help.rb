module LonoCfn
  class CLI < Thor
    class Help
      class << self
        def create
<<-EOL
Examples:

Provided that you are in a lono project and have a `my-stack` lono template definition.  To create a stack you can simply run:

$ lono-cfn create my-stack

The above command will generate and use the template in output/my-stack.json and parameters in params/my-stack.txt.  The template defaults by convention to the name of the stack.  The params defaults by convention to the name of the template in turn.  The convention allows the command to be a very nice short command that can be easily remembered.  Both conventions can be overridden.

Here are examples of overriding the template and params name conventions.

$ lono-cfn create my-stack --template different-name1

The template that will be use is output/different-name1.json and the parameters will use params/different-name1.json.

$ lono-cfn create my-stack --params different-name2

The template that will be use is output/different-name2.json and the parameters will use params/different-name2.json.

$ lono-cfn create my-stack --template different-name3 --params different-name4

The template that will be use is output/different-name3.json and the parameters will use params/different-name4.json.

EOL
        end
      end
    end
  end
end
