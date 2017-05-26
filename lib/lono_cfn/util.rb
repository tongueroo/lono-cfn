module LonoCfn
  module Util
    def are_you_sure?(action)
      if @options[:sure]
        sure = 'y'
      else
        puts "Are you sure you want to want to #{action} the stack with the changes? (y/N)"
        sure = $stdin.gets
      end

      unless sure =~ /^y/
        puts "Exiting without #{action}"
        exit 0
      end
    end
  end
end
