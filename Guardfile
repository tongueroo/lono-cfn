guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})      { "spec/lono-cfn_spec.rb" }
  watch(%r{^lib/lono-cfn/(.+)\.rb$})  { "spec/lono-cfn_spec.rb" }
  watch('spec/spec_helper.rb')   { "spec/lono-cfn_spec.rb" }
  watch(%r{^lib/lono-cfn/(.+)\.rb$})   { |m| "spec/lib/#{m[1]}_spec.rb" }
end

guard 'bundler' do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end
