module Ruboty
    module Docker
        module Actions
            class Start < Base
                def call
                    container = message[:container_name]

                    @start_thread = ::Thread.new { ::Docker::Container.get(container).start
                    message.reply("Start #{container}")
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
