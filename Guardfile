guard :shell do
    watch(%r{lib/ruboty/handlers/.*\.rb$}) do |m|
        `echo #{m.first} was reloaded`
    end
end

guard :bundler do
    watch('Gemfile')
    watch(/^.+\.gemspec/)
end
