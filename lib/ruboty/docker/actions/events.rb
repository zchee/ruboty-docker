module Ruboty
    module Docker
        module Actions
            module Events
                class Start < Ruboty::Actions::Base
                    def call
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
                end

                class Stop < Ruboty::Actions::Base
                    def call
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
end
