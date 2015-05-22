guard :rspec, cmd: 'rspec' do
  watch(%r{^spec/.+_spec\.rb$}) { 'spec' }
  watch(%r{^lib/(.+)\.rb$})  { 'spec' }
  watch('spec/spec_helper.rb') { 'spec' }

  watch(%r{^spec/factories/(.+)\.rb$}) { 'spec/factories_spec.rb' }
  watch(%r{^spec/support/(.+)\.rb$}) { 'spec' }
end

guard :bundler do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end
