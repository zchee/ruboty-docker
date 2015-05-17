module Ruboty
    module Docker
        module Actions
            class Events < Ruboty::Actions::Base
                def docker_events_start(message)
                    @stream = Thread.new { ::Docker::Event.stream do |event|
                        response = ['docker event response', event.status, event.id, event.from, event.time].join("\s")
                        message.reply response
                    end }
                    message.reply('Start Docker events stream server')
                rescue => e
                    value = [e.class.name, e.message].join("\n")
                    message.reply value
                ensure
                end

                def docker_events_stop(message)
                    Thread.kill(@stream)
                    message.reply('Stop Docker events stream server')
                rescue => e
                    value = [e.class.name, e.message].join("\n")
                    message.reply value
                ensure
                end
            end
        end
    end
end
