module Ruboty
    module Handlers
        class Docker < Base
            NAMESPACE = 'docker'

            ::Docker.url = ENV['RUBOTY_DOCKER_HOST'] || 'unix:///var/run/docker.sock'

            on /docker build (?<code>.+)/m, name: 'docker_build', description: 'Build an image form a code'
            on /docker events\z/, name: 'docker_events', description: 'Start real time events stream watch thread'
            on /docker(?<debug>.+?)images\z/m, name: 'docker_images', description: 'List images'
            on /docker(?<debug>.+?)info\z/m, name: 'docker_info', description: 'Display system-vide information'
            on /docker(?<debug>.+?)inspect (?<target_name>.+)/m, name: 'docker_inspect', description: 'Return low-level information on a contaitner or image'
            on /docker(?<debug>.+?)ps\z/m, name: 'docker_ps', description: 'List containers'
            on /docker(?<debug>.+?)pull (?<image_name>.+)/m, name: 'docker_pull', description: 'Pull an image or a repository from a Docker registry server'
            on /docker rm (?<container_name>.+)/, name: 'docker_rm', description: 'Remove one or more containers'
            on /docker rmi(?<debug>.+?)(?<image_name>.+)/m, name: 'docker_rmi', description: 'Remove one or more images'
            on /docker run (?<image_name>.+?) \[(?<args>.+?)\] (?<command>.+)/m, name: 'docker_run', description: 'Run a command in a nemw container'
            on /docker start (?<container_name>.+)/, name: 'docker_start', description: 'Start a stopped container'
            on /docker stop (?<container_name>.+)/, name: 'docker_stop', description: 'Stop a running container'
            on /docker thread\z/, name: 'docker_thread', description: 'Check current Ruby thread'
            on /docker top (?<container_name>.+)/, name: 'docker_top', description: 'Stop a running container'

            def docker_events(message)
                Ruboty::Docker::Actions::Events.new(message).call
            end

            def docker_build(message)
                Ruboty::Docker::Actions::Build.new(message).call
            end

            def docker_images(message)
                Ruboty::Docker::Actions::Images.new(message).call
            end

            def docker_info(message)
                Ruboty::Docker::Actions::Info.new(message).call
            end

            def docker_inspect(message)
                Ruboty::Docker::Actions::Inspect.new(message).call
            end

            def docker_ps(message)
                Ruboty::Docker::Actions::Ps.new(message).call
            end

            def docker_pull(message)
                Ruboty::Docker::Actions::Pull.new(message).call
            end

            def docker_rm(message)
                Ruboty::Docker::Actions::Rm.new(message).call
            end

            def docker_rmi(message)
                Ruboty::Docker::Actions::Rmi.new(message).call
            end

            def docker_run(message)
                Ruboty::Docker::Actions::Run.new(message).call
            end

            def docker_start(message)
                Ruboty::Docker::Actions::Start.new(message).call
            end

            def docker_stop(message)
                Ruboty::Docker::Actions::Stop.new(message).call
            end

            def docker_thread(message)
                Ruboty::Docker::Actions::Thread.new(message).call
            end

            def docker_top(message)
                Ruboty::Docker::Actions::Top.new(message).call
            end
        end
    end
end
