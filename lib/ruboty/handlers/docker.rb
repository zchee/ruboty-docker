module Ruboty
    module Handlers
        class Docker < Base
            NAMESPACE = 'docker'

            ::Docker.url = ENV['RUBOTY_DOCKER_HOST'] || 'unix:///var/run/docker.sock'

            on /docker build (?<code>.+)/m, name: 'docker_build', description: 'Build an image form a code'
            on /docker events start\z/, name: 'docker_events_start', description: 'Start real time events stream server'
            on /docker events stop\z/, name: 'docker_events_stop', description: 'Stop real time events stream server'
            on /docker(?<debug>.+?)images\z/m, name: 'docker_images', description: 'List images'
            on /docker(?<debug>.+?)info\z/m, name: 'docker_info', description: 'Display system-vide information'
            on /docker(?<debug>.+?)inspect (?<image_name>.+)/m, name: 'docker_inspect', description: 'Return low-level information on a contaitner or image'
            on /docker(?<debug>.+?)ps\z/m, name: 'docker_ps', description: 'List containers'
            on /docker(?<debug>.+?)pull (?<image_name>.+)/m, name: 'docker_pull', description: 'Pull an image or a repository from a Docker registry server'
            on /docker rm\z/, name: 'docker_rm', description: 'Remove one or more containers'
            on /docker rmi(?<debug>.+?)(?<image_name>.+)/m, name: 'docker_rmi', description: 'Remove one or more images'
            on /docker run (?<image_name>.+?) \[(?<args>.+?)\] (?<command>.+)/m, name: 'docker_run', description: 'Run a command in a nemw container'

            def docker_events_start(message)
                Ruboty::Docker::Actions::Events::Start.new(message).call
            end

            def docker_events_stop(message)
                Ruboty::Docker::Actions::Events::Stop.new(message).call
            end

            def docker_build(message)
                Ruboty::Docker::Actions::Events::Build.new(message).call
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
        end
    end
end
