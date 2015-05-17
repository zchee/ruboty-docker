# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/docker/version'

Gem::Specification.new do |spec|
    spec.name    = 'ruboty-docker'
    spec.version = Ruboty::Docker::VERSION
    spec.authors = ['zchee']
    spec.email   = ['zcheeee@gmail.com']

    spec.summary     = %q{summary}
    spec.description = %q{desc}
    spec.homepage    = 'https://github.com/zchee/ruboty-docker'
    spec.license     = 'MIT'

    # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
    # delete this section to allow pushing this gem to any host.
    if spec.respond_to?(:metadata)
        spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
    else
        raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
    end

    spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    spec.bindir        = 'exe'
    spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.require_paths = ['lib']

    spec.add_runtime_dependency 'docker-api', '~> 1.21'
    spec.add_runtime_dependency 'ruboty', '~> 1.2'
    spec.add_runtime_dependency 'terminal-table', '~> 1.4'

    spec.add_development_dependency 'awesome_print'
    spec.add_development_dependency 'bundler', '~> 1.9'
    spec.add_development_dependency 'ci_reporter'
    spec.add_development_dependency 'codeclimate-test-reporter'
    spec.add_development_dependency 'coveralls'
    spec.add_development_dependency 'pry'
    spec.add_development_dependency 'rake', '~> 10.0'
    spec.add_development_dependency 'rspec'
    spec.add_development_dependency 'simplecov'
    spec.add_development_dependency 'simplecov-rcov'
end
