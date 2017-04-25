require 'thor'
require 'lono_cfn/cli/help'

module LonoCfn

  class CLI < Thor
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean
    class_option :project_root, desc: "Project folder.  Defaults to current directory", default: '.'
    class_option :region, desc: "AWS region"

    # common to create and update
    class_option :template, desc: 'override convention and specify the template file to use'
    class_option :params, desc: 'override convention and specify the params file to use'
    class_option :lono, type: :boolean, desc: 'invoke lono to generate CloudFormation templates', default: true

    desc "create STACK", "create a CloudFormation stack"
    long_desc Help.create
    def create(name)
      Create.new(name, options).run
    end

    desc "update STACK", "update a CloudFormation stack"
    long_desc Help.update
    def update(name)
      Update.new(name, options).run
    end

    desc "delete STACK", "delete a CloudFormation stack"
    long_desc Help.delete
    def delete(name)
      Delete.new(name, options).run
    end
  end
end
