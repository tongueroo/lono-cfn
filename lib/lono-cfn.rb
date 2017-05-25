$:.unshift(File.expand_path("../", __FILE__))
require "lono_cfn/version"

require "colorize"

# use vendored lono-params
$:.unshift(File.expand_path("../../vendor/lono-params/lib", __FILE__))
require "lono-params"

module LonoCfn
  autoload :AwsServices, 'lono_cfn/aws_services'
  autoload :CLI, 'lono_cfn/cli'
  autoload :Base, 'lono_cfn/base'
  autoload :Create, 'lono_cfn/create'
  autoload :Update, 'lono_cfn/update'
  autoload :Delete, 'lono_cfn/delete'
  autoload :Plan, 'lono_cfn/plan'
end
