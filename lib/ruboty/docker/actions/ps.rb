module Ruboty
    module Docker
        module Actions
            class PsAll < Base
                def call
                    containers = ::Docker::Container
                    rows       = []
                    message.reply(containers.all(:all => true), code: true) if message[:debug] == ' -D '
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
                    value = [e.class.name, e.message, e.backtrace].join("\n")
                    message.reply value
                ensure
                end
            end
        end
    end
end
