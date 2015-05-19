module Ruboty
    module Docker
        module Actions
            class Pull < Ruboty::Actions::Base
                def call
                    image_name = message[:image_name]
                    message.reply("Pulling from #{image_name}...")
                    image = ::Docker::Image.create('fromImage' => image_name)
                    message.reply("Status: Downloaded newer image for #{image_name}")
                    message.reply(image.json, code: true) if message[:debug] == ' -D '
                    rows = []
                    rows.push ['IMAGE NAME', image_name]
                    rows.push ['IMAGE ID', image.json['Id']]
                    rows.push ['VirtualSize', filesize_to_human(image.json['VirtualSize'])]
                    rows.push ['OS', image.json['Os']]
                    unless image.json['Config']['Env'].blank?
                        image.json['Config']['Env'].each_index do |n|
                            if n == 0
                                rows.push ['Env', image.json['Config']['Env'][n]]
                            else
                                rows.push ['', image.json['Config']['Env'][n]]
                            end
                        end
                    end
                    unless image.json['Config']['Env'].blank?
                        image.json['Config']['OnBuild'].each_index do |n|
                            if n == 0
                                rows.push ['OnBuild', image.json['Config']['OnBuild'][n]]
                            else
                                rows.push ['', image.json['Config']['OnBuild'][n]]
                            end
                        end
                    end
                    rows.push ['Cmd', image.json['ContainerConfig']['Cmd']]
                    rows.push ['WorkingDir', image.json['ContainerConfig']['WorkingDir']]
                    rows.push ['Created', image.json['Created']]
                    rows.push ['DockerVersion', image.json['DockerVersion']]

                    table       = ::Terminal::Table.new title: 'PULLED IMAGE INFO', rows: rows
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
