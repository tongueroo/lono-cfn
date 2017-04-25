require 'spec_helper'

# to run specs with what's remembered from vcr
#   $ rake
#
# to run specs with new fresh data from aws api calls
#   $ rake clean:vcr ; time rake
describe LonoCfn::CLI do
  before(:all) do
    @args = "--noop --project-root spec/fixtures/my_project"
  end

  describe "lono-cfn" do
    it "creates stack" do
      out = execute("bin/lono-cfn create my-stack #{@args}")
      expect(out).to include("stack creating.")
    end

    it "updates stack" do
      out = execute("bin/lono-cfn update my-stack #{@args}")
      expect(out).to include("stack updating.")
    end

    it "deletes stack" do
      out = execute("bin/lono-cfn delete my-stack #{@args}")
      expect(out).to include("Deleted")
    end
  end
end
