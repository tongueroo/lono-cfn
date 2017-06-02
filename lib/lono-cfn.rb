$:.unshift(File.expand_path("../", __FILE__))
require "lono-cfn/version"

require "colorize"

# use vendored lono-params
$:.unshift(File.expand_path("../../vendor/lono-params/lib", __FILE__))
require "lono-params"

module LonoCfn
  autoload :AwsServices, 'lono-cfn/aws_services'
  autoload :Util, 'lono-cfn/util'
  autoload :CLI, 'lono-cfn/cli'
  autoload :Base, 'lono-cfn/base'
  autoload :Create, 'lono-cfn/create'
  autoload :Update, 'lono-cfn/update'
  autoload :Delete, 'lono-cfn/delete'
  autoload :Plan, 'lono-cfn/plan'
end
