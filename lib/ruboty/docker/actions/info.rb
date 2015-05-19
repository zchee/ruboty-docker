module Ruboty
    module Docker
        module Actions
            class Info < Base
                def call
                    info = ::Docker.info
                    message.reply(info, code: true) if message[:debug] == ' -D '
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
            end
        end
    end
end
