# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/docker/version'

Gem::Specification.new do |spec|
    spec.name    = 'ruboty-docker'
    spec.version = Ruboty::Docker::VERSION
    spec.authors = ['zchee']
    spec.email   = ['zcheeee@gmail.com']

    spec.summary     = %q{Management Docker via Ruboty ChatOps}
    spec.description = %q{Management Docker via Ruboty ChatOps}
    spec.homepage    = 'https://github.com/zchee/ruboty-docker'
    spec.license     = 'MIT'

    spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.require_paths = ['lib']

    spec.add_runtime_dependency 'docker-api', '>= 1.21'
    spec.add_runtime_dependency 'ruboty', '>= 1.2'
    spec.add_runtime_dependency 'terminal-table', '>= 1.4'
    spec.add_development_dependency 'awesome_print', '>= 1.6'
    spec.add_development_dependency 'bundler', '>= 1.9'
    spec.add_development_dependency 'codeclimate-test-reporter', '>= 0.4'
    spec.add_development_dependency 'coveralls', '>= 0.8'
    spec.add_development_dependency 'rake', '>= 10.0'
    spec.add_development_dependency 'rspec', '>= 3.2'
    spec.add_development_dependency 'simplecov', '>= 0.10'
    spec.add_development_dependency 'simplecov-rcov', '>= 0.2'
end
