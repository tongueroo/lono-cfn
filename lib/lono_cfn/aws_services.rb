require "aws-sdk"

module LonoCfn
  module AwsServices
    def cfn
      @cfn ||= Aws::CloudFormation::Client.new
    end
  end
end
