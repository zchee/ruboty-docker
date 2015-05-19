module Ruboty
    module Docker
        module Actions
            class Rm < Base
                def call
                    container = message[:container_name]

                    @rm_thread = ::Thread.new { ::Docker::Container.get(container).remove
                    message.reply("Delete #{container}")
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
