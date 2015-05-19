module Ruboty
    module Docker
        module Actions
            class Events < Base
                def call
                    ::Thread.new {
                        ::Docker::Event.stream do |event|
                            response = ['docker event response', event.status, event.id, event.from, event.time].join("\s")
                            message.reply response
                        end
                    }
                    message.reply('Start real time events stream watch thread')
                rescue => e
                    value = [e.class.name, e.message, e.backtrace].join("\n")
                    message.reply value
                ensure
                end
            end
        end
    end
end
