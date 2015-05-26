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
    @docker = Docker
  end

  let(:docker_host) do
    @docker.url
  end

  let(:require_docker_host) do
    '1.6'
  end

  let(:docker_version) do
    @docker.version['Version'][0..-3]
  end

  let(:docker_cerc_path) do
    ENV['DOCKER_CERT_PATH']
  end

  let!(:docker_info) do
    docker.info
  end

  it 'must be "$RUBOTY_DOCKER_HOST"' do
    expect(docker_version).to eq require_docker_host
  end
end
