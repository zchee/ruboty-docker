module Ruboty
    module Docker
        module Actions
            class Inspect < Ruboty::Actions::Base
                def call
                    images = ::Docker::Image.get(message[:image_name])
                    info   = images.instance_variable_get(:@info)
                    message.reply(info, code: true) if message[:debug] == ' -D '
                    rows = []
                    rows.push ['ID', images.instance_variable_get(:@id)]
                    rows.push ['Architecture', info['Architecture']]
                    rows.push ['Author', info['Author']]
                    rows.push ['Command', info['Config']['Cmd']]
                    unless info['Config']['Env'].blank?
                        info['Config']['Env'].each_index do |n|
                            if n == 0
                                rows.push ['Env', info['Config']['Env'][n]]
                            else
                                rows.push ['', info['Config']['Env'][n]]
                            end
                        end
                    end
                    unless info['Config']['OnBuild'].blank?
                        info['Config']['OnBuild'].each_index do |n|
                            if n == 0
                                rows.push ['OnBuild', info['Config']['OnBuild'][n]]
                            else
                                rows.push ['', info['Config']['OnBuild'][n]]
                            end
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
            end
        end
    end
end
