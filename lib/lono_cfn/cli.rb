require "thor"
require "lono_cfn/cli/help"

module LonoCfn

  class CLI < Thor
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean
    class_option :project_root, desc: "Project folder.  Defaults to current directory", default: "."
    class_option :region, desc: "AWS region"

    # common to create and update
    class_option :template, desc: "override convention and specify the template file to use"
    class_option :params, desc: "override convention and specify the params file to use"
    class_option :lono, type: :boolean, desc: "invoke lono to generate CloudFormation templates", default: true

    desc "create STACK", "create a CloudFormation stack"
    long_desc Help.create
    def create(name)
      Create.new(name, options).run
    end

    desc "update STACK", "update a CloudFormation stack"
    long_desc Help.update
    option :change_set, type: :boolean, default: true, desc: "Uses generated change set to update the stack.  If false, will perform normal update-stack."
    option :preview, type: :boolean, default: true, desc: "Prints preview of the stack changes before continuing."
    option :sure, type: :boolean, desc: "Skips are you sure prompt"
    def update(name)
      Update.new(name, options).run
    end

    desc "delete STACK", "delete a CloudFormation stack"
    long_desc Help.delete
    option :sure, type: :boolean, desc: "Skips are you sure prompt"
    def delete(name)
      Delete.new(name, options).run
    end

    desc "plan STACK", "preview a CloudFormation stack update"
    long_desc Help.plan
    option :keep, type: :boolean, desc: "keep the changeset instead of deleting it afterwards"
    def plan(name)
      Plan.new(name, options).run
    end
  end
end
