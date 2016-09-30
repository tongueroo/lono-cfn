require 'thor'
require 'lono_cfn/cli/help'

module LonoCfn

  class CLI < Thor
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean
    class_option :project_root, desc: "Project folder.  Defaults to current directory", default: '.'

    desc "create STACK", "create a CloudFormation stack"
    long_desc Help.create
    option :template, desc: 'override convention and specify the template file to use'
    option :params, desc: 'override convention and specify the params file to use'
    option :lono, type: :boolean, desc: 'invoke lono to generate CloudFormation templates', default: true
    option :use_previous_value, type: :boolean, default: true, desc: "On an update whether to use the previous parameters values.  Applies for all parameters."
    def create(name)
      Create.new(name, options).run
    end
  end
end
