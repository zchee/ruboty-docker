require File.expand_path('spec/spec_helper')
require 'docker'
require 'socket'
require 'json'
require 'pp'

describe Ruboty::Handlers::Docker do
  let!(:robot) do
    Ruboty::Robot.new
  end

  let!(:docker) do
    Docker.url = ENV['RUBOTY_DOCKER_HOST']
    Docker
  end

  before(:all) {
    ::Docker.url = ENV['RUBOTY_DOCKER_HOST']
    @version     = ::Docker.version['Version']
    @info        = ::Docker.info
  }

  let(:docker_host) do
    ENV['RUBOTY_DOCKER_HOST']
  end

  let(:docker_cerc_path) do
    ENV['DOCKER_CERT_PATH']
  end

  let(:docker_version) do
    Docker.version['Version']
  end

  let!(:docker_info) do
    Docker.info
  end

  it 'must be "$RUBOTY_DOCKER_HOST"' do
    expect(@version).to eq `/usr/local/bin/docker version | awk 'NR==6 {print$3}'`.gsub(/$\n/) { $1 }
  end

  it 'must be match Docker version' do
    expect(@version).to eq '1.6.0'
  end
end
