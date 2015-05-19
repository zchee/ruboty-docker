module Ruboty
    module Docker
        module Actions
            class Stop < Base
                def call
                    container = message[:container_name]

                    @stop_thread = ::Thread.new { ::Docker::Container.get(container).stop
                    message.reply("Stop #{container}")
                    }
                rescue => e
                    value = [e.class.name, e.message, e.backtrace].join("\n")
                    message.reply value
                ensure
                end
            end
        end
    end
end
