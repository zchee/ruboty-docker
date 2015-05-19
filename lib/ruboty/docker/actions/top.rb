module Ruboty
    module Docker
        module Actions
            class Top < Base
                def call
                    container = message[:container_name]
                    top  = ::Docker::Container.get(container).top
                    rows = []
                    top.each do |t|
                        rows.push [t['PID'], t['USER'], t['COMMAND']]
                    end
                    table       = ::Terminal::Table.new title: 'CONTAINER TOP', headings: ['PID', 'USER', 'COMMAND'], rows: rows
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
