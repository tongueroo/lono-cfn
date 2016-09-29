$:.unshift(File.expand_path("../", __FILE__))
require "lono_cfn/version"
require "pp"

module LonoCfn
  autoload :CLI, 'lono_cfn/cli'
  autoload :Create, 'lono_cfn/create'
end
