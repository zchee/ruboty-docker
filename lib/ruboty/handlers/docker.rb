module Ruboty
    module Handlers
        class Docker < Base
            NAMESPACE = 'docker'

            ::Docker.url = ENV['RUBOTY_DOCKER_HOST'] || 'unix:///var/run/docker.sock'

            on /docker build (?<code>.+)/m, name: 'docker_build', description: 'Build an image form a code'
            # on /docker commmit\z/, name: 'docker_commit', description: "Create a nev image from a container's changes"
            # on /docker cp\z/, name: 'docker_cp', description: "Copy files/folders from a container's filesystem to the host path"
            # on /docker create\z/, name: 'docker_create', description: 'Create a new container'
            # on /docker diff\z/, name: 'docker_diff', description: "Inspect changes on a container's filesystem"
            # on /docker events\z/, name: 'docker_events', description: 'Get real timme events from the server'
            # on /docker exec\z/, name: 'docer_exec', description: 'Run a command in a running container'
            # on /docker export\z/, name: 'docker_export', description: 'Stream the contents of a container sa a tar archive'
            # on /docker history\z/, name: 'docker_history', description: 'Show the history of an image'
            on /docker images\z/, name: 'docker_images', description: 'List images'
            # on /docker import\z/, name: 'docker_import', description: 'Create a nev filesystem image from a container or image'
            on /docker info\z/, name: 'docker_info', description: 'Display system-vide information'
            on /docker inspect (?<image_name>.+)/, name: 'docker_inspect', description: 'Return low-level information on a contaitner or image'
            # on /docker kill\z/, name: 'docker_kill', description: 'Kill a runnig container'
            # on /docker load\z/, name: 'docker_load', description: 'Load an image from a tar archive'
            # on /docker login (?<username>.+) (?<password>.+) (?<email>.+)/, name: 'docker_login', description: 'Register or Login to Docker reginstry server'
            # on /docker logout\z/, name: 'docker_logout', description: 'Log out from a Docker rugistry server'
            # on /docker logs\z/, name: 'docker_logs', description: 'Fetch the logs of a container'
            # on /docker port\z/, name: 'docker_port', description: 'Lookup the pubilc-facing port that is NAT-ed to PRIVATE_PORT'
            # on /docker pause\z/, name: 'docker_pause', description: 'Pause all processes whthin a container'
            on /docker ps\z/, name: 'docker_ps', description: 'List containers'
            on /docker pull (?<image_name>.+)/, name: 'docker_pull', description: 'Pull an image or a repository from a Docker registry server'
            # on /docker push\z/, name: 'docker_push', description: 'Push an image or a repository to a Docker rugistry server'
            # on /docker rename\z/, name: 'docker_rename', description: 'Rename an existing container'
            # on /docker restart\z/, name: 'docker_restart', description: 'Restart a running container'
            # on /docker rm \z/, name: 'docker_rm', description: 'Remove one or more containers'
            on /docker rmi (?<image_name>.+)/, name: 'docker_rmi', description: 'Remove one or more images'
            # on /docker run\z/, name: 'docker_run', description: 'Run a command in a nemw container'
            # on /docker save\z/, name: 'docker_save', description: 'Save an imaeg to a tar archive'
            # on /docker search\z/, name: 'docker_search', description: 'Search ofr an image on the Docker Hub'
            # on /docker start\z/, name: 'docker_start', description: 'Start a stopped container'
            # on /docker stats\z/, name: 'docker_stats', description: "Display as stream of a containers' resource usage statistics"
            # on /docker stop\z/, name: 'docker_stop', description: 'Stop a running container'
            # on /docker tag\z/, name: 'docker_tag', description: 'Tag an image into a repository'
            # on /docker top\z/, name: 'docker_top', description: 'Lookup the running processes of a container'
            # on /docker unpause\z/, name: 'docker_unpause', description: 'Unpause as paused container'
            # on /docker version\z/, name: 'docker_version', description: 'Show the Docker version information'
            # on /docker wait\z/, name: 'docker_wait', description: 'Block until a container stops, then print its exit code'

            def docker_build(message)
                message_args = message[:code].to_s.split("\n", 2)
                repo_name    = message_args[0].split(':')[0]
                tag          = message_args[0].split(':')[1]
                dockerfile   = message_args[1].to_s[4..-5]

                message.reply('Building this Dockerfile...')
                message.reply(dockerfile, code: true)
                build = ::Docker::Image.build(dockerfile).tag(repo: repo_name, tag: tag)
                ap build
                ap repo_name
                ap dockerfile
                message.reply('Done')
            rescue => e
                value = [e.class.name, e.message, e.backtrace].join("\n")
                message.reply value
            ensure
            end

            def docker_images(message)
                images = ::Docker::Image.all
                rows   = []
                images.each do |image|
                    repository = image.info['RepoTags'].to_s.split(':')[0]
                    tag        = image.info['RepoTags'].to_s.split(':')[1]
                    id         = image.info['id'].to_s.scan(/.{1,#{12}}/)
                    size       = filesize_to_human(image.info['VirtualSize'])
                    rows.push [repository[2..100], tag[0..-3], id[0], size]
                end
                table       = ::Terminal::Table.new headings: ['REPOSITORY', 'TAG', 'IMAGE ID', 'VIRTUALSIZE'], rows: rows
                table.style = { :padding_left => 0, :border_x => ' ', :border_y => ' ', :border_i => ' ' }
                message.reply(table, code: true)
            rescue => e
                value = [e.class.name, e.message, e.backtrace].join("\n")
                message.reply value
            ensure
            end

            def docker_info(message)
                info = ::Docker.info
                rows = []
                rows.push ['Containers', info['Containers']]
                rows.push ['Debug', info['Debug']]
                rows.push ['DockerRootDir', info['DockerRootDir']]
                rows.push ['Driver', info['Driver']]
                rows.push ['DriverStatus', '']
                rows.push ['  Root Dir', info['DriverStatus'][0][1]]
                rows.push ['  Backing Filesystem', info['DriverStatus'][1][1]]
                rows.push ['  Dirs', info['DriverStatus'][2][1]]
                rows.push ['  Dirperm1 Supperted', info['DriverStatus'][3][1]]
                rows.push ['ExecutionDriver', info['ExecutionDriver']]
                rows.push ['ID', info['ID']]
                rows.push ['IPv4Forwarding', info['IPv4Forwarding']]
                rows.push ['Images', info['Images']]
                rows.push ['IndexServerAddress', info['IndexServerAddress']]
                rows.push ['InitPath', info['InitPath']]
                rows.push ['InitSha1', info['InitSha1']]
                rows.push ['KernelVersion', info['KernelVersion']]
                rows.push ['Labels', info['Labels'].to_s[2..-3]]
                rows.push ['MemTotal', info['MemTotal']]
                rows.push ['MemoryLimit', info['MemoryLimit']]
                rows.push ['NCPU', info['NCPU']]
                rows.push ['NEventsListener', info['NEventsListener']]
                rows.push ['NFd', info['NFd']]
                rows.push ['NGoroutines', info['NGoroutines']]
                rows.push ['Name', info['Name']]
                rows.push ['OperatingSystem', info['OperatingSystem'].to_s.split(':')[0]]
                # rows   << ['RegistryConfigs', info['RegistryConfigs']]
                # rows   << ['IndexName', info['RegistryConfigs'][0][0]]
                # rows   << ['Mirrors', info['RegistryConfigs']['IndexConfigs']['docker.io']['Mirrors']]
                # rows   << ['Official', info['RegistryConfigs']['IndexConfigs']['docker.io']['Official']]
                # rows   << ['Secure', info['RegistryConfigs']['IndexConfigs']['docker.io']['Secure']]
                rows.push ['SwapLimit', info['SwapLimit']]
                rows.push ['SystemTime', info['SystemTime']]
                table       = ::Terminal::Table.new title: 'DOCKER INFO', rows: rows
                table.style = { :padding_left => 0, :border_x => '', :border_y => ' ', :border_i => '' }
                message.reply(table, code: true)
            rescue => e
                value = [e.class.name, e.message, e.backtrace].join("\n")
                message.reply value
            ensure
            end

            def docker_inspect(message)
                images = ::Docker::Image.get(message[:image_name])
                info   = images.instance_variable_get(:@info)
                rows   = []
                rows.push ['ID', images.instance_variable_get(:@id)]
                rows.push ['Architecture', info['Architecture']]
                rows.push ['Author', info['Author']]
                rows.push ['Command', info['Config']['Cmd']]
                info['Config']['Env'].each_index do |n|
                    if n == 0
                        rows.push ['Env', info['Config']['Env'][n]]
                    else
                        rows.push ['', info['Config']['Env'][n]]
                    end
                end
                info['Config']['OnBuild'].each_index do |n|
                    if n == 0
                        rows.push ['OnBuild', info['Config']['OnBuild'][n]]
                    else
                        rows.push ['', info['Config']['OnBuild'][n]]
                    end
                end
                rows.push ['Port Specs', info['Config']['PortSpecs']]
                rows.push ['User', info['Config']['User']]
                rows.push ['Volumes', info['Config']['Volumes']]
                rows.push ['Working Dir', info['Config']['WorkingDir']]

                table       = ::Terminal::Table.new title: 'DOCKER INSPECT', rows: rows
                table.style = { :padding_left => 0, :border_x => '', :border_y => ' ', :border_i => '' }
                message.reply(table, code: true)
            rescue => e
                value = [e.class.name, e.message].join("\n")
                message.reply value
            ensure
            end

            def docker_ps(message)
                containers = ::Docker::Container
                rows       = []
                containers.all(:all => true).each do |c|
                    command = [c.instance_variable_get(:@info)['Command']].to_s[2..16]
                    created = [c.instance_variable_get(:@info)['Created']].to_s[2..-3]
                    image   = [c.instance_variable_get(:@info)['Image']].to_s[2..-3]
                    label   = [c.instance_variable_get(:@info)['Labels']].to_s[2..-3]
                    names   = [c.instance_variable_get(:@info)['Names']].to_s[4..-4]
                    # TODO: Depth variable. and private & public ports.
                    # ports =  [c.instance_variable_get(:@info)['Ports']].to_s[2..-3]
                    status  = [c.instance_variable_get(:@info)['Status']].to_s[2..-3]
                    id      = [c.instance_variable_get(:@info)['id'].to_s[0..12]].to_s[2..-3]

                    rows.push [id, image, command, created, status, names, label]
                end
                table       = ::Terminal::Table.new headings: ['CONTAINER ID', 'IMAGE', 'COMMAND', 'CREATED', 'STATUS', 'NAMES'], rows: rows
                table.style = { :padding_left => 0, :border_x => '', :border_y => ' ', :border_i => '' }
                message.reply(table, code: true)
            rescue => e
                value = ["'pull' requires 1 argument. See @#{ENV['RUBOTY_NAME']} help", e.class.name, e.message, e.backtrace].join("\n")
                message.reply value
            ensure
            end

            def docker_pull(message)
                image_name = message[:image_name]
                message.reply("Pulling from #{image_name}...")
                image = ::Docker::Image.create('fromImage' => image_name)
                message.reply("Status: Downloaded newer image for #{image_name}")
                rows = []
                rows.push ['IMAGE NAME', image_name]
                rows.push ['IMAGE ID', image.json['Id']]
                rows.push ['VirtualSize', filesize_to_human(image.json['VirtualSize'])]
                rows.push ['OS', image.json['Os']]
                rows.push ['OnBuild', image.json['Config']['OnBuild']]
                rows.push ['Cmd', image.json['ContainerConfig']['Cmd']]
                rows.push ['WorkingDir', image.json['ContainerConfig']['WorkingDir']]
                rows.push ['Created', image.json['Created']]
                rows.push ['DockerVersion', image.json['DockerVersion']]

                table       = ::Terminal::Table.new title: 'PULLED IMAGE INFO', rows: rows
                table.style = { :padding_left => 0, :border_x => '', :border_y => ' ', :border_i => '' }
                message.reply(table, code: true)
            rescue => e
                value = ["'pull' requires 1 argument. See @#{ENV['RUBOTY_NAME']} help", e.class.name, e.message, e.backtrace].join("\n")
                message.reply value
            ensure
            end

            def docker_rmi(message)
                image_name = message[:image_name]
                message.reply("Deleting from #{image_name}...")
                image = ::Docker::Image.get(image_name).remove(force: true)
                message.reply image
            rescue => e
                value = [e.class.name, e.message, e.backtrace].join("\n")
                message.reply value
            ensure
            end

            private

            def filesize_to_human(n)
                count = 0
                while n >= 1000 and count < 4
                    n     /= 1000.0
                    count += 1
                end
                format('%.2f', n) + %w(B KB MB GB TB)[count]
            end
        end
    end
end
